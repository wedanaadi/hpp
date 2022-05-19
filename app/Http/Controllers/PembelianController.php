<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\Barang;
use App\Models\JurnalUmum;
use App\Models\Pembelian;
use App\Models\PembelianDetail;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Webpatser\Uuid\Uuid;

class PembelianController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return Pembelian::with('supplier', 'detail', 'detail.barang')->orderBy('id', 'asc')->get();
    }
    $datas = Pembelian::all();
    return ['datas' => $datas];
  }

  public function show($id)
  {
    return Pembelian::with('supplier', 'detail', 'detail.barang')->findOrFail($id);
  }

  public function store(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'tanggal' => 'required',
      'desc' => 'required',
      'supplier' => 'required',
      'akun' => 'required',
      'barangbuy' => 'required|array',
    ], [
      'supplier.required' => 'Field Supplier harus diisi!.',
      'akun.required' => 'Field Akun harus diisi!.',
      'desc.required' => 'Field Deskripsi harus diisi!.',
      'tanggal.required' => 'Field Tanggal harus diisi!.',
      'barangbuy.required' => 'List Barang harus diisi!.',
      'array' => 'Field :attribute harus array!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    DB::beginTransaction();
    try {
      $date = date('y') . date('m');
      $lastKode = Pembelian::select(DB::raw('MAX(id) AS kode'))
        ->where(DB::raw('SUBSTR(id,3,4)'), $date)
        ->first();
      $newKode = Fungsi::KodeGenerate($lastKode->kode, 5, 6, 'TP', $date);
      $data = [
        'id' => $newKode,
        'tanggal' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
        'akun_id' => $request->akun,
        'supplier_id' => $request->supplier,
        'jumlah_trx' => $request->total,
        'desc' => $request->desc,
      ];

      $detail = [];
      foreach ($request->barangbuy as $row) {
        $detail[] = [
          'id' => Uuid::generate()->string,
          'pembelian_id' => $newKode,
          'barang_id' => $row['barangid'],
          'unit' => $row['unit'],
          'qty' => $row['qty'],
          'harga' => $row['price'],
          'harga_terakhir' => $row['lastPrice'],
        ];
        $barangData = Barang::findOrFail($row['barangid']);
        $dataUpBarang = [
          'stock' => $barangData->stock + $row['qty'],
          'harga_beli' => $row['price'],
          'last_purchase_price' => $row['lastPrice'],
        ];
        $barangData->update($dataUpBarang);
      }
      $dataJurnal = [
        'id' => Uuid::generate()->string,
        'akun' => $request->akun,
        'debet' => 0,
        'kredit' => $request->total,
        'remark' => $newKode . ' ' . $request->desc,
        'link_id' => $newKode,
        'date' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
      ];
      Pembelian::create($data);
      PembelianDetail::insert($detail);
      JurnalUmum::create($dataJurnal);
      DB::commit();
      $respon = [
        'message' => "Data pembelian berhasil ditambah.",
        'data' => $data,
        'icon' => 'success'
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ['icon' => 'error', "message" => $e->getMessage()];
    }
  }

  public function update(Request $request, $id)
  {
    $validator = Validator::make($request->all(), [
      'tanggal' => 'required',
      'desc' => 'required',
      'supplier' => 'required',
      'akun' => 'required',
      'barangbuy' => 'required|array',
    ], [
      'supplier.required' => 'Field Supplier harus diisi!.',
      'akun.required' => 'Field Akun harus diisi!.',
      'desc.required' => 'Field Deskripsi harus diisi!.',
      'tanggal.required' => 'Field Tanggal harus diisi!.',
      'barangbuy.required' => 'List Barang harus diisi!.',
      'array' => 'Field :attribute harus array!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $pembelian = Pembelian::findOrFail($id);
    $jurnalUmum = JurnalUmum::where('link_id', $id)->firstOrFail();
    DB::beginTransaction();
    try {
      // restored data insert
      $detail = PembelianDetail::where('pembelian_id', $id)->get();
      foreach ($detail as $d) {
        $barangData = Barang::find($d->barang_id);
        $databarang = [
          'stock' => $barangData->stock - $d->qty,
        ];
        $barangData->update($databarang);
      }
      $jurnalUmum->delete();
      PembelianDetail::where('pembelian_id', $id)->delete();
      // end restored data insert

      // data baru
      $data = [
        'tanggal' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
        'akun_id' => $request->akun,
        'supplier_id' => $request->supplier,
        'jumlah_trx' => $request->total,
        'desc' => $request->desc,
      ];

      $detail = [];
      foreach ($request->barangbuy as $row) {
        $detail[] = [
          'id' => Uuid::generate()->string,
          'pembelian_id' => $id,
          'barang_id' => $row['barangid'],
          'unit' => $row['unit'],
          'qty' => $row['qty'],
          'harga' => $row['price'],
          'harga_terakhir' => $row['lastPrice'],
        ];
        $barangData = Barang::findOrFail($row['barangid']);
        $dataUpBarang = [
          'stock' => $barangData->stock + $row['qty'],
          'harga_beli' => $row['price'],
          'last_purchase_price' => $row['lastPrice'],
        ];
        $barangData->update($dataUpBarang);
      }
      $dataJurnal = [
        'id' => Uuid::generate()->string,
        'akun' => $request->akun,
        'debet' => 0,
        'kredit' => $request->total,
        'remark' => $id . ' ' . $request->desc,
        'link_id' => $id,
        'date' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
      ];

      $pembelian->update($data);
      PembelianDetail::insert($detail);
      JurnalUmum::create($dataJurnal);

      DB::commit();
      $respon = [
        'message' => "Data pembelian berhasil diubah.",
        // 'data' => $data,
        'icon' => 'success'
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ['icon' => 'error', "message" => $e->getMessage()];
    }
  }

  public function cetakHeader()
  {
    return view('laporan.headerReport');
  }

  public function report(Request $request)
  {
    $data = DB::select("SELECT t_pembelian.*,m_supplier.nama, m_barang.nama_barang,t_pembelian_detail.qty,t_pembelian_detail.harga,
                date_format(`t_pembelian`.tanggal,'%Y-%m-%d') AS 'tgl'
                from t_pembelian
                INNER JOIN t_pembelian_detail on t_pembelian_detail.pembelian_id = t_pembelian.id
                INNER join m_supplier on m_supplier.id = t_pembelian.supplier_id
                INNER JOIN m_barang on m_barang.id = t_pembelian_detail.barang_id
                WHERE DATE_FORMAT(t_pembelian.tanggal,'%Y-%m') = '$request->date'; ");
    $pisahTanggal = explode("-", $request->date);
    $bulan = $pisahTanggal[1];
    $header = $this->cetakHeader();
    $konten = [
      'body' => $data,
      'bulan' => Fungsi::bulan($bulan) . ' ' . $pisahTanggal[0]
    ];
    $html = view('laporan.pembelian', compact('konten', 'header'));
    return Pdf::loadHTML($html)->setPaper('A4', 'portrait')->stream('Pembelian-' . Fungsi::bulan($bulan) . '-' . $pisahTanggal[0] . '.pdf');
  }
}
