<?php

namespace App\Http\Controllers;

use App\Models\Supplier;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Webpatser\Uuid\Uuid;

class SupplierController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return Supplier::orderBy('nama', 'asc')->where('is_aktif', 1)->get();
    }
    $datas = Supplier::all();
    return ['datas' => $datas];
  }

  public function store(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'kode_pemasok' => [
        'required',
        Rule::unique('m_supplier')->where(function ($query) {
          return $query->where('is_aktif', 1);
        })
      ],
      'nama' => "required|string",
      'alamat' => "required|string",
      'telepon' => "required|string",
    ], [
      'unique' => 'Field :attribute harus unik!.',
      'required' => 'Field :attribute harus diisi!.',
      'string' => 'Field :attribute berupa string!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    DB::beginTransaction();
    try {
      $data = [
        'id' => Uuid::generate()->string,
        'kode_pemasok' => $request->kode_pemasok,
        'nama' => $request->nama,
        'alamat' => $request->alamat,
        'telp' => $request->telepon,
      ];

      Supplier::create($data);
      DB::commit();
      $respon = [
        'message' => "Data supplier berhasil disimpan.",
        'data' => $data
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }

  public function update(Request $request, $id)
  {
    $validator = Validator::make($request->all(), [
      'kode_pemasok' => [
        'required',
        Rule::unique('m_supplier')->where(function ($query) {
          return $query->where('is_aktif', 1);
        })->ignore($id, 'id')
      ],
      'nama' => "required|string",
      'alamat' => "required|string",
      'telepon' => "required|string",
    ], [
      'unique' => 'Field :attribute harus unik!.',
      'required' => 'Field :attribute harus diisi!.',
      'string' => 'Field :attribute berupa string!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $supplier = Supplier::findOrFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'kode_pemasok' => $request->kode_pemasok,
        'nama' => $request->nama,
        'alamat' => $request->alamat,
        'telp' => $request->telepon,
      ];

      $supplier->update($data);
      DB::commit();
      $respon = [
        'message' => "Data supplier berhasil diubah.",
        'data' => $data
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }

  public function destroy($id)
  {
    $supplier = Supplier::findOrFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'is_aktif' => 0
      ];

      $supplier->update($data);
      DB::commit();
      $respon = [
        'message' => "Data supplier berhasil dihapus.",
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }
}
