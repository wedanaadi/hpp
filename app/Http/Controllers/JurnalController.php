<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\Barang;
use App\Models\JurnalUmum;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Webpatser\Uuid\Uuid;

class JurnalController extends Controller
{
    public function index(Request $request)
    {
        if ($request->input('showdata')) {
            return JurnalUmum::with('akuns')->orderBy('date', 'desc')->get();
        }

        $datas = JurnalUmum::all();
        return ['data' => $datas];
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'date' => "required",
            'akun' => "required",
            'debet' => "required|numeric",
            'kredit' => "required|numeric",
            'remark' => "required",
        ], [
            'required' => 'Field :attribute harus diisi!.',
            'numeric' => 'Field :attribute berupa angka!.',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        DB::beginTransaction();
        try {
            $data = [
                'id' => Uuid::generate()->string,
                'akun' => $request->akun,
                'debet' => $request->debet,
                'kredit' => $request->kredit,
                'remark' => $request->remark,
                'link_id' => 0,
                'date' => Carbon::parse($request->date)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
            ];
            JurnalUmum::create($data);
            DB::commit();
            $respon = [
                'message' => "Data jurnal umum berhasil disimpan.",
                'icon' => "success",
                'data' => $data
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => "error", "message" => $e->getMessage()];
        }
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'date' => "required",
            'akun' => "required",
            'debet' => "required|numeric",
            'kredit' => "required|numeric",
            'remark' => "required",
        ], [
            'required' => 'Field :attribute harus diisi!.',
            'numeric' => 'Field :attribute berupa angka!.',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $jurnal = JurnalUmum::findOrFail($id);
        DB::beginTransaction();
        try {
            $data = [
                'akun' => $request->akun,
                'debet' => $request->debet,
                'kredit' => $request->kredit,
                'remark' => $request->remark,
                'link_id' => 0,
                'date' => Carbon::parse($request->date)->setTimezone('Asia/Makassar')->format('Y-m-d H:i:s'),
            ];
            $jurnal->update($data);
            DB::commit();
            $respon = [
                'message' => "Data jurnal umum berhasil dirubah.",
                'icon' => "success",
                'data' => $data
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => "error", "message" => $e->getMessage()];
        }
    }

    public function cetakHeader()
    {
        return view('laporan.headerReport');
    }

    public function hitung_lb($date)
    {
        $penjualan = DB::select("SELECT ifnull(sum(jumlah_trx),0) as 'total' from t_penjualan p
    where date_format(p.tanggal, '%Y-%m') = '$date';")[0]->total;
        $pembelian = DB::select("SELECT ifnull(sum(jumlah_trx),0) as 'total' from t_pembelian p
    where date_format(p.tanggal, '%Y-%m') = '$date';")[0]->total;
        $produksi = DB::select("SELECT ifnull(sum(overhead_cost),0) as 'overhead',
                ifnull(sum(bahan_cost),0) as 'produksi'
                from t_produksi p
                where date_format(tanggal,'%Y-%m') = '$date'")[0];
        $gaji = DB::select("SELECT ifnull(sum(debet),0)-ifnull(sum(kredit),0) as 'total' from t_jurnal_umum u
            where date_format(u.`date`,'%Y-%m') = '$date' AND akun = '7ddecf40-bc12-11ec-80d7-652d0c0589f8'")[0]->total;
        return [
            'pj' => $penjualan,
            'pb' => $pembelian,
            'gaji' => $gaji,
            'produksi' => $produksi
        ];
    }

    public function report_lb(Request $request)
    {
        $pisahTanggal = explode("-", $request->date);
        $bulan = $pisahTanggal[1];
        $header = $this->cetakHeader();
        $konten = [
            'body' => $this->hitung_lb($request->date),
            'bulan' => Fungsi::bulan($bulan) . ' ' . $pisahTanggal[0]
        ];
        $html = view('laporan.labarugi', compact('konten', 'header'));
        return Pdf::loadHTML($html)->setPaper('A4', 'portrait')->stream('Labarugi-' . Fungsi::bulan($bulan) . '-' . $pisahTanggal[0] . '.pdf');
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
        $data =  [
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
        //
        return $data['biayaproduksi'] - (-1 * (($bakuprev + $pembelian) - $totalProses));
    }

    public function hitung_neraca($date)
    {
        $kas = DB::select("SELECT ifnull(sum(debet),0)-ifnull(sum(kredit),0) as 'total' from t_jurnal_umum u
            where date_format(u.`date`,'%Y-%m') = '$date' AND akun = 'e3ddb460-bc11-11ec-be0b-15fa23b08e4f'")[0]->total;
        $hpp = DB::select("SELECT ifnull(sum(desired_cost),0) as 'total' FROM t_produksi p
            where date_format(p.tanggal,'%Y-%m')='$date';")[0]->total;
        $baku = DB::select("select IFNULL(sum(stock * harga_jual),0) as 'total' from m_barang b")[0]->total;
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
        $gaji = DB::select("SELECT ifnull(sum(debet),0)-ifnull(sum(kredit),0) as 'total' from t_jurnal_umum u
            where date_format(u.`date`,'%Y-%m') = '$date' AND akun = '7ddecf40-bc12-11ec-80d7-652d0c0589f8'")[0]->total;
        $modal = DB::select("SELECT ifnull(sum(debet),0)-ifnull(sum(kredit),0) as 'total' from t_jurnal_umum u
            where date_format(u.`date`,'%Y-%m') = '$date' AND akun = '3fb95260-bc12-11ec-81b9-891ac0a8faf0'")[0]->total;
        $dlb = $this->hitung_lb($date);
        $labarugi = ($dlb['pj'] - $dlb['pb']) - ($dlb['gaji'] + $dlb['produksi']->overhead + $dlb['produksi']->produksi);
        return [
            'kas' => $kas,
            'baku' => $baku,
            'proses' => -1 * $totalProses,
            'hpp' => $this->hitung_hpp($date),
            'kewajiban' => abs($gaji),
            'modal' => $modal,
            'lb' => $labarugi,
        ];
    }

    public function report_neraca(Request $request)
    {
        $pisahTanggal = explode("-", $request->date);
        $bulan = $pisahTanggal[1];
        $header = $this->cetakHeader();
        $konten = [
            'body' => $this->hitung_neraca($request->date),
            'bulan' => Fungsi::bulan($bulan) . ' ' . $pisahTanggal[0]
        ];
        $html = view('laporan.neraca', compact('konten', 'header'));
        return Pdf::loadHTML($html)->setPaper('A4', 'portrait')->stream('Neraca-' . Fungsi::bulan($bulan) . '-' . $pisahTanggal[0] . '.pdf');
    }
}
