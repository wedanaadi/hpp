<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\Barang;
use App\Models\Produksi;
use App\Models\ProduksiDetail;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Webpatser\Uuid\Uuid;

class ProduksiController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return Produksi::with('detail', 'detail.barang', 'detail.barang.unit')->orderBy('id', 'asc')->get();
    }
    $datas = Produksi::all();
    return ['datas' => $datas];
  }

  public function brg_hpp(Request $request)
  {
    return Produksi::with('detail', 'menu', 'menu.subcategory.category', 'detail.barang', 'detail.barang.unit')
      ->where('barang_id', $request->id)
      ->orderBy('id', 'desc')->first();
  }

  public function show($id)
  {
    return Produksi::with('detail', 'detail.barang', 'detail.barang.unit')->findOrFail($id);
  }

  public function store(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'tanggal' => 'required',
      'key' => 'required',
      'preparation' => 'required',
      'stockProduksi' => 'required|gt:0',
      'menu' => 'required',
      'projectedSellCost' => 'required|gt:0',
      'barangbuy' => 'required|array',
    ], [
      'key.required' => 'Field Key Ingredient harus diisi!.',
      'preparation.required' => 'Field Preparation harus diisi!.',
      'menu.required' => 'Field Receipt harus diisi!.',
      'tanggal.required' => 'Field Tanggal harus diisi!.',
      'barangbuy.required' => 'List Ingredient harus diisi!.',
      'gt' => 'List :attribute harus lebih besar dari 0!.',
      'array' => 'Field :attribute harus array!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    DB::beginTransaction();
    try {
      $date = date('y') . date('m');
      $lastKode = Produksi::select(DB::raw('MAX(id) AS kode'))
        ->where(DB::raw('SUBSTR(id,2,4)'), $date)
        ->first();
      $newKode = Fungsi::KodeGenerate($lastKode->kode, 5, 6, 'P', $date);
      $data = [
        'id' => $newKode,
        'bahan_cost' => $request->total,
        'overhead_cost' => $request->overhead,
        'desired_cost' => $request->disered,
        'project_sell' => $request->projectedSellCost,
        'tax_cost' => $request->tax,
        'sell_price' => $request->sell,
        'key_ing' => $request->key,
        'preparation' => $request->preparation,
        'barang_id' => $request->menu,
        'stock_produksi' => $request->stockProduksi,
        'tanggal' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
      ];
      $detail = [];
      foreach ($request->barangbuy as $row) {
        $detail[] = [
          'id' => Uuid::generate()->string,
          'produksi_id' => $newKode,
          'bahan_id' => $row['barangid'],
          'unit' => $row['unit'],
          'qty' => $row['qty'],
          'price' => $row['cost'],
          'total' => $row['grandTotal'],
        ];
        $barangData = Barang::findOrFail($row['barangid']);
        $qty = $row['qty'];
        if (strtolower($row['unit']) === 'kg' or strtolower($row['unit']) === 'ml') {
          $qty = $row['qty'] / 1000;
        }
        $dataUpBarang = [
          'stock' => $barangData->stock - $qty,
        ];
        $barangData->update($dataUpBarang);
      }
      Produksi::create($data);
      ProduksiDetail::insert($detail);
      $barangJadi = Barang::find($request->menu);
      $barangJadi->update([
        'harga_jual' => $request->sell,
        'stock' => $barangJadi->stock + $request->stockProduksi,
      ]);
      DB::commit();
      $respon = [
        'message' => "Data produksi berhasil ditambah.",
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
      'key' => 'required',
      'preparation' => 'required',
      'menu' => 'required',
      'projectedSellCost' => 'required|gt:0',
      'stockProduksi' => 'required|gt:0',
      'barangbuy' => 'required|array',
    ], [
      'key.required' => 'Field Key Ingredient harus diisi!.',
      'preparation.required' => 'Field Preparation harus diisi!.',
      'menu.required' => 'Field Receipt harus diisi!.',
      'tanggal.required' => 'Field Tanggal harus diisi!.',
      'barangbuy.required' => 'List Ingredient harus diisi!.',
      'gt' => 'List :attribute harus lebih besar dari 0!.',
      'array' => 'Field :attribute harus array!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $produksi = Produksi::findOrFail($id);
    DB::beginTransaction();
    try {
      // restored data insert
      $detail = ProduksiDetail::where('produksi_id', $id)->get();
      foreach ($detail as $d) {
        $barangData = Barang::find($d->bahan_id);
        $qty = $d->qty;
        if (strtolower($d->unit) === 'kg' or strtolower($d->unit) === 'ml') {
          $qty = $d->qty / 1000;
        }
        $databarang = [
          'stock' => $barangData->stock + $qty,
        ];
        $barangData->update($databarang);
      }
      ProduksiDetail::where('produksi_id', $id)->delete();
      // end restored data insert

      // baru
      $data = [
        'bahan_cost' => $request->total,
        'overhead_cost' => $request->overhead,
        'desired_cost' => $request->disered,
        'project_sell' => $request->projectedSellCost,
        'tax_cost' => $request->tax,
        'sell_price' => $request->sell,
        'key_ing' => $request->key,
        'preparation' => $request->preparation,
        'barang_id' => $request->menu,
        'stock_produksi' => $request->stockProduksi,
        'tanggal' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
      ];
      $detail = [];
      foreach ($request->barangbuy as $row) {
        $detail[] = [
          'id' => Uuid::generate()->string,
          'produksi_id' => $id,
          'bahan_id' => $row['barangid'],
          'unit' => $row['unit'],
          'qty' => $row['qty'],
          'price' => $row['cost'],
          'total' => $row['grandTotal'],
        ];
        $barangData = Barang::findOrFail($row['barangid']);
        $qty = $row['qty'];
        if (strtolower($row['unit']) === 'kg' or strtolower($row['unit']) === 'ml') {
          $qty = $row['qty'] / 1000;
        }
        $dataUpBarang = [
          'stock' => $barangData->stock - $qty,
        ];
        $barangData->update($dataUpBarang);
      }
      $produksi->update($data);
      ProduksiDetail::insert($detail);
      $barangJadi = Barang::find($request->menu);
      $barangJadi->update([
        'harga_jual' => $request->sell,
        'stock' => $barangJadi->stock + $request->stockProduksi,
      ]);
      DB::commit();
      $respon = [
        'message' => "Data produksi berhasil dirubah.",
        'data' => $data,
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

  public function hitung_hpp($date)
  {
    $baku = DB::select("select IFNULL(sum(stock * harga_jual),0) as 'total' from m_barang b WHERE jenis='1'")[0]->total;
    $pembelian = DB::select("select ifnull(sum(jumlah_trx),0) as 'total' from t_pembelian p 
    where date_format(tanggal,'%Y-%m') = '$date'")[0]->total;
    $bakuprev = $baku - $pembelian;
    $proddetil = DB::select("select pd.bahan_id,pd.unit,pd.price, pd.qty
                  from t_produksi p 
                  INNER join t_produksi_detail pd on pd.produksi_id = p.id
                  where date_format(p.tanggal,'%Y-%m') = '$date'");
    $totalProses = 0;
    foreach ($proddetil as $v) {
      if (strtolower($v->unit) === 'kg' or strtolower($v->unit) === 'ml') {
        $qty = $v->qty / 1000;
      } else {
        $qty = $v->qty;
      }
      $b = Barang::find($v->bahan_id);
      $totalProses += $qty * $b->harga_beli;
    }
    $produksi = DB::select("SELECT ifnull(sum(overhead_cost),0) as 'overhead',
                ifnull(sum(bahan_cost),0) as 'produksi'
                from t_produksi p
                where date_format(tanggal,'%Y-%m') = '$date'")[0];
    $gaji = DB::select("SELECT ifnull(sum(debet),0)-ifnull(sum(kredit),0) as 'total' from t_jurnal_umum u
            where date_format(u.`date`,'%Y-%m') = '$date' AND akun = '7ddecf40-bc12-11ec-80d7-652d0c0589f8'")[0]->total;
    $hpp = DB::select("SELECT ifnull(sum(sell_price*stock_produksi),0) as 'total' FROM t_produksi p
            where date_format(p.tanggal,'%Y-%m')='$date';")[0]->total;
    return [
      'stockawal' => $bakuprev,
      'pembelian' => $pembelian,
      'tersedia' => $bakuprev + $pembelian,
      'sisabahan' => ($bakuprev + $pembelian) - $totalProses,
      'pemakain' => $totalProses,
      'gaji' => abs($gaji),
      'overhead' => $produksi->overhead,
      'produksi' => $produksi->produksi,
      'totalbiaya' => abs($gaji) + $produksi->overhead + $produksi->produksi,
      'biayaproduksi' => (abs($gaji) + $produksi->overhead + $produksi->produksi) + $totalProses,
    ];
  }

  public function report(Request $request)
  {
    $pisahTanggal = explode("-", $request->date);
    $bulan = $pisahTanggal[1];
    $header = $this->cetakHeader();
    $konten = [
      'body' => $this->hitung_hpp($request->date),
      'bulan' => Fungsi::bulan($bulan) . ' ' . $pisahTanggal[0]
    ];
    $html = view('laporan.hpp', compact('konten', 'header'));
    return Pdf::loadHTML($html)->setPaper('A4', 'portrait')->stream('HPP-' . Fungsi::bulan($bulan) . '-' . $pisahTanggal[0] . '.pdf');
  }
}
