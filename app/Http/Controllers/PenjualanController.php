<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\Barang;
use App\Models\JurnalUmum;
use App\Models\Penjualan;
use App\Models\PenjualanDetail;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Webpatser\Uuid\Uuid;

class PenjualanController extends Controller
{
    public function index(Request $request)
    {
        if ($request->input('showdata')) {
            return Penjualan::with('detail', 'detail.barang')->orderBy('id', 'asc')->get();
        }
        $datas = Penjualan::all();
        return ['datas' => $datas];
    }

    public function show($id)
    {
        return Penjualan::with('detail', 'detail.barang')->findOrFail($id);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'tanggal' => 'required',
            'desc' => 'required',
            'akun' => 'required',
            'barangbuy' => 'required|array',
        ], [
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
            $lastKode = Penjualan::select(DB::raw('MAX(id) AS kode'))
                ->where(DB::raw('SUBSTR(id,3,4)'), $date)
                ->first();
            $newKode = Fungsi::KodeGenerate($lastKode->kode, 5, 6, 'TS', $date);
            $data = [
                'id' => $newKode,
                'tanggal' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
                'akun_id' => $request->akun,
                'jumlah_trx' => $request->total,
                'desc' => $request->desc,
            ];

            $detail = [];
            foreach ($request->barangbuy as $row) {
                $detail[] = [
                    'id' => Uuid::generate()->string,
                    'penjualan_id' => $newKode,
                    'barang_id' => $row['barangid'],
                    'unit' => $row['unit'],
                    'qty' => $row['qty'],
                    'harga' => $row['price'],
                    'actual_harga' => $row['priceActual'],
                    'total' => $row['grandTotal'],
                ];
                $barangData = Barang::findOrFail($row['barangid']);
                $dataUpBarang = [
                    'stock' => $barangData->stock - $row['qty'],
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
            Penjualan::create($data);
            PenjualanDetail::insert($detail);
            JurnalUmum::create($dataJurnal);
            DB::commit();
            $respon = [
                'message' => "Data penjualan berhasil ditambah.",
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
            'akun' => 'required',
            'barangbuy' => 'required|array',
        ], [
            'akun.required' => 'Field Akun harus diisi!.',
            'desc.required' => 'Field Deskripsi harus diisi!.',
            'tanggal.required' => 'Field Tanggal harus diisi!.',
            'barangbuy.required' => 'List Barang harus diisi!.',
            'array' => 'Field :attribute harus array!.',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $penjualan = Penjualan::findOrFail($id);
        $jurnalUmum = JurnalUmum::where('link_id', $id)->firstOrFail();
        DB::beginTransaction();
        try {
            // restored data insert
            $detail = PenjualanDetail::where('penjualan_id', $id)->get();
            foreach ($detail as $d) {
                $barangData = Barang::find($d->barang_id);
                $databarang = [
                    'stock' => $barangData->stock + $d->qty,
                ];
                $barangData->update($databarang);
            }
            $jurnalUmum->delete();
            PenjualanDetail::where('penjualan_id', $id)->delete();
            // end restored data insert

            // data baru
            $data = [
                'tanggal' => Carbon::parse($request->tanggal)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
                'akun_id' => $request->akun,
                'jumlah_trx' => $request->total,
                'desc' => $request->desc,
            ];

            $detail = [];
            foreach ($request->barangbuy as $row) {
                $detail[] = [
                    'id' => Uuid::generate()->string,
                    'penjualan_id' => $id,
                    'barang_id' => $row['barangid'],
                    'unit' => $row['unit'],
                    'qty' => $row['qty'],
                    'harga' => $row['price'],
                    'actual_harga' => $row['priceActual'],
                    'total' => $row['grandTotal'],
                ];
                $barangData = Barang::findOrFail($row['barangid']);
                $dataUpBarang = [
                    'stock' => $barangData->stock - $row['qty'],
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

            $penjualan->update($data);
            PenjualanDetail::insert($detail);
            JurnalUmum::create($dataJurnal);

            DB::commit();
            $respon = [
                'message' => "Data penjualan berhasil diubah.",
                // 'data' => $data,
                'icon' => 'success'
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => 'error', "message" => $e->getMessage()];
        }
    }

    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            Penjualan::findOrFail($id)->delete();
            PenjualanDetail::where('penjualan_id', $id)->delete();
            JurnalUmum::where('link_id', $id)->delete();
            DB::commit();
            $respon = [
                'message' => "Data penjualan berhasil dihapus.",
                'icon' => 'success',
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => 'error', "error" => $e->getMessage()];
        }
    }

    public function cetakHeader()
    {
        return view('laporan.headerReport');
    }

    public function report(Request $request)
    {
        $data = DB::select("select date_format(p.tanggal,'%Y-%m-%d') As 'date', b.nama_barang, b.kode, s.nama_satuan,
                        pd.qty, pd.total, pd.harga, pd.actual_harga
                        FROM t_penjualan p
                        INNER join t_penjualan_detail pd on pd.penjualan_id = p.id
                        inner join m_barang b on b.id = pd.barang_id
                        inner join m_satuan s on s.id = b.satuan_id
                        WHERE date_format(p.tanggal,'%Y-%m') = '$request->date'");
        $pisahTanggal = explode("-", $request->date);
        $bulan = $pisahTanggal[1];
        $header = $this->cetakHeader();
        $konten = [
            'body' => $data,
            'bulan' => Fungsi::bulan($bulan) . ' ' . $pisahTanggal[0]
        ];
        $html = view('laporan.penjualan', compact('konten', 'header'));
        return Pdf::loadHTML($html)->setPaper('A4', 'portrait')->stream('Penjualan-' . Fungsi::bulan($bulan) . '-' . $pisahTanggal[0] . '.pdf');
    }
}
