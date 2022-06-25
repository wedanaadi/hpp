<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\Barang;
use App\Models\Unit;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Webpatser\Uuid\Uuid;

class BarangController extends Controller
{
    public function index(Request $request)
    {
        if ($request->input('showdata')) {
            return Barang::with('unit', 'subcategory.category')->orderBy('kode', 'asc')->where('is_aktif', 1)->where('jenis', '1')->get();
        }
        $datas = Barang::where('jenis', 1)->get();
        return ['datas' => $datas];
    }

    public function brg_baku()
    {
        return Barang::with('unit')
            ->orderBy('kode', 'asc')
            ->where(['is_aktif' => "1", "jenis" => "1"])
            ->get();
    }

    public function brg_Jadi()
    {
        return Barang::with('unit')
            ->orderBy('kode', 'asc')
            ->where(['is_aktif' => "1", "jenis" => "2"])
            ->get();
    }

    public function brg_produksi(Request $request)
    {
        $decode = base64_decode($request->id);
        return Barang::with('unit')
            ->orderBy('kode', 'asc')
            ->where('is_aktif', "1")
            ->where('id', '!=', $decode)
            ->get();
    }

    public function brg_jual()
    {
        return Barang::orderBy('kode', 'asc')
            ->orderBy('stock', 'desc')
            ->where('is_aktif', '1')
            ->where('jenis', '2')
            // ->where('stock', '>', '0')
            ->get();
    }

    public function store(Request $request)
    {
        // dd($request->file);
        $validator = Validator::make($request->all(), [
            'articleNo' => 'required',
            'desc' => 'required',
            'jenis' => 'required',
            'unit' => 'required',
            'subcategory' => 'required',
            'stock' => 'required',
            'avrg' => 'required|gt:0',
            'file' => 'nullable|image|mimes:jpeg,png,jpg|max:2048'
        ], [
            'articleNo.required' => 'Field article no. harus diisi!.',
            'desc.required' => 'Field nama barang harus diisi!.',
            'jenis.required' => 'Field jenis barang harus diisi!.',
            'unit.required' => 'Field unit barang harus diisi!.',
            'stock.required' => 'Field stock barang harus diisi!.',
            'subcategory.required' => 'Field subcategory barang harus diisi!.',
            'avrg.required' => 'Field average price harus diisi!.',
            'gt' => 'Field average price harus lebih besar dari 0',
            'image' => 'File tidak valid',
            'mimes' => 'Format gambar harus jpeg/png/jpg'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // dd($request->file->getClientOriginalName());

        DB::beginTransaction();
        try {
            $newIdBarang = Uuid::generate()->string;
            $data = [
                'id' => $newIdBarang,
                'kode' => $request->articleNo,
                'jenis' => $request->jenis,
                'nama_barang' => $request->desc,
                'harga_beli' => $request->avrg,
                'harga_jual' => $request->jenis === '1' ? $request->avrg : 0,
                'stock' => $request->stock,
                'satuan_id' => $request->unit,
                'subcategory_id' => $request->subcategory,
                'last_purchase_price' => "0",
                'is_aktif' => "1",
            ];
            if ($request->file) {
                $dataImage = $request->file;
                $destinationPath = 'images/barang';
                $profileImage = $newIdBarang . "=" . $dataImage->getClientOriginalName();
                $dataImage->move($destinationPath, $profileImage);
                $data['foto'] = $profileImage;
            }

            Barang::create($data);
            DB::commit();
            $respon = [
                'message' => "Data barang berhasil disimpan.",
                'icon' => 'success',
                'data' => $data
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
            'articleNo' => 'required',
            'desc' => 'required',
            'jenis' => 'required',
            'unit' => 'required',
            'subcategory' => 'required',
            'stock' => 'required',
            'avrg' => 'required|gt:0',
            'file' => 'nullable|image|mimes:jpeg,png,jpg|max:2048'
        ], [
            'articleNo.required' => 'Field article no. harus diisi!.',
            'desc.required' => 'Field nama barang harus diisi!.',
            'jenis.required' => 'Field jenis barang harus diisi!.',
            'unit.required' => 'Field unit barang harus diisi!.',
            'stock.required' => 'Field stock barang harus diisi!.',
            'subcategory.required' => 'Field subcategory barang harus diisi!.',
            'avrg.required' => 'Field average price harus diisi!.',
            'gt' => 'Field average price harus lebih besar dari 0',
            'image' => 'File tidak valid',
            'mimes' => 'Format gambar harus jpeg/png/jpg'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $barang = Barang::findOrFail($id);
        DB::beginTransaction();
        try {
            $data = [
                'kode' => $request->articleNo,
                'jenis' => $request->jenis,
                'nama_barang' => $request->desc,
                'harga_beli' => $request->avrg,
                'harga_jual' => $request->jenis === '1' ? $request->avrg : 0,
                'stock' => $request->stock,
                'satuan_id' => $request->unit,
                'subcategory_id' => $request->subcategory,
                'last_purchase_price' => "0",
                'is_aktif' => "1",
            ];
            if ($request->file) {
                $dataImage = $request->file;
                if ($request->oldFoto !== null) {
                    $splitFoto = explode('=', $request->oldFoto);
                    if ($dataImage->getClientOriginalName() !== $splitFoto[1]) {
                        unlink('images/barang/' . $request->oldFoto);
                    }
                }
                $destinationPath = 'images/barang';
                $profileImage = $id . "=" . $dataImage->getClientOriginalName();
                $dataImage->move($destinationPath, $profileImage);
                $data['foto'] = $profileImage;
            }

            $barang->update($data);
            DB::commit();
            $respon = [
                'message' => "Data barang berhasil diubah.",
                'icon' => 'success',
                'data' => $data
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => 'error', "message" => $e->getMessage()];
        }
    }

    public function destroy($id)
    {
        $akun = Barang::findOrFail($id);
        DB::beginTransaction();
        try {
            $akun->update(['is_aktif' => "0"]);
            DB::commit();
            $respon = [
                'message' => "Data barang berhasil dihapus.",
                'icon' => 'success',
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => 'error', "error" => $e->getMessage()];
        }
    }

    public function unit()
    {
        return Unit::all();
    }

    public function saveUnit(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nama_satuan' => [
                'required',
                'unique:m_satuan'
            ],
        ], [
            'unique' => 'Field Unit sudah ada!.',
            'required' => 'Field Unit harus diisi!.',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        DB::beginTransaction();
        try {
            $data = [
                'id' => Uuid::generate()->string,
                'nama_satuan' => $request->nama_satuan,
            ];
            Unit::create($data);
            DB::commit();
            $unit  = DB::table('m_satuan')->get();
            $respon = [
                'message' => "Data unit berhasil disimpan.",
                'unit' => $unit
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ["error" => $e->getMessage()];
        }
    }

    public function cetakHeader()
    {
        return view('laporan.headerReport');
    }

    public function report(Request $request)
    {
        $data = DB::select("select b.*, s.nama_satuan from m_barang b
                        INNER join m_satuan s on s.id = b.satuan_id
                        where b.is_aktif = '1';");
        $pisahTanggal = explode("-", $request->date);
        $bulan = $pisahTanggal[1];
        $header = $this->cetakHeader();
        $konten = [
            'body' => $data,
            'bulan' => Fungsi::bulan($bulan) . ' ' . $pisahTanggal[0]
        ];
        $html = view('laporan.stock', compact('konten', 'header'));
        return Pdf::loadHTML($html)->setPaper('A4', 'portrait')->stream('Stock-' . Fungsi::bulan($bulan) . '-' . $pisahTanggal[0] . '.pdf');
    }
}
