<?php

namespace App\Http\Controllers;

use App\Models\Barang;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Webpatser\Uuid\Uuid;

class MenuController extends Controller
{
    public function index(Request $request)
    {
        if ($request->input('showdata')) {
            return Barang::with('unit', 'subcategory.category')->orderBy('kode', 'asc')->where('is_aktif', 1)->where('jenis', '2')->get();
        }
        $datas = Barang::where('jenis', "2")->get();
        return ['datas' => $datas];
    }

    public function store(Request $request)
    {
        // dd($request->file);
        $validator = Validator::make($request->all(), [
            'articleNo' => 'required',
            'desc' => 'required',
            'jenis' => 'required',
            // 'unit' => 'required',
            // 'subcategory' => 'required',
            // 'stock' => 'required',
            // 'avrg' => 'required|gt:0',
            'file' => 'nullable|image|mimes:jpeg,png,jpg|max:2048'
        ], [
            'articleNo.required' => 'Field article no. harus diisi!.',
            'desc.required' => 'Field nama menu harus diisi!.',
            'jenis.required' => 'Field jenis menu harus diisi!.',
            // 'unit.required' => 'Field unit menu harus diisi!.',
            // 'stock.required' => 'Field stock menu harus diisi!.',
            // 'subcategory.required' => 'Field subcategory menu harus diisi!.',
            // 'avrg.required' => 'Field average price harus diisi!.',
            // 'gt' => 'Field average price harus lebih besar dari 0',
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
                'harga_beli' => 0,
                'harga_jual' => 0,
                // 'harga_jual' => $request->jenis === '1' ? $request->avrg : 0,
                'stock' => 0,
                'satuan_id' => null,
                'subcategory_id' => null,
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
                'message' => "Data menu berhasil disimpan.",
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
            // 'unit' => 'required',
            // 'subcategory' => 'required',
            // 'stock' => 'required',
            // 'avrg' => 'required|gt:0',
            'file' => 'nullable|image|mimes:jpeg,png,jpg|max:2048'
        ], [
            'articleNo.required' => 'Field article no. harus diisi!.',
            'desc.required' => 'Field nama menu harus diisi!.',
            'jenis.required' => 'Field jenis menu harus diisi!.',
            // 'unit.required' => 'Field unit menu harus diisi!.',
            // 'stock.required' => 'Field stock menu harus diisi!.',
            // 'subcategory.required' => 'Field subcategory menu harus diisi!.',
            // 'avrg.required' => 'Field average price harus diisi!.',
            // 'gt' => 'Field average price harus lebih besar dari 0',
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
                'harga_jual' => $request->avrg,
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
                'message' => "Data menu berhasil diubah.",
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
                'message' => "Data menu berhasil dihapus.",
                'icon' => 'success',
            ];
            return response()->json($respon, 201);
        } catch (\Exception $e) {
            DB::rollback();
            return ['icon' => 'error', "error" => $e->getMessage()];
        }
    }
}
