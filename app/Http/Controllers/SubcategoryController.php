<?php

namespace App\Http\Controllers;

use App\Models\Subcategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Webpatser\Uuid\Uuid;

class SubcategoryController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return Subcategory::with('category')->orderBy('subcategory_name', 'asc')->where('is_aktif', 1)->get();
    }
    $datas = Subcategory::all();
    return ['datas' => $datas];
  }

  public function store(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'category_id' => "required",
      'subcategory_name' => "required",
      'subcategory_code' => "required|numeric|gt:0",
    ], [
      'category_id.required' => 'Field Category harus diisi!.',
      'required' => 'Field :attribute harus diisi!.',
      'numeric' => 'Field :attribute berupa angka!.',
      'gt' => 'Field :attribute harus lebih dari 0!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    DB::beginTransaction();
    try {
      $data = [
        'id' => Uuid::generate()->string,
        'category_id' => $request->category_id,
        'subcategory_name' => $request->subcategory_name,
        'code_subcategory' => $request->subcategory_code,
      ];

      Subcategory::create($data);
      DB::commit();
      $respon = [
        'message' => "Data subcategory berhasil disimpan.",
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
      'category_id' => "required",
      'subcategory_name' => "required",
      'subcategory_code' => "required|numeric|gt:0",
    ], [
      'category_id.required' => 'Field Category harus diisi!.',
      'required' => 'Field :attribute harus diisi!.',
      'numeric' => 'Field :attribute berupa angka!.',
      'gt' => 'Field :attribute harus lebih dari 0!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $supplier = Subcategory::findOrFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'category_id' => $request->category_id,
        'subcategory_name' => $request->subcategory_name,
        'code_subcategory' => $request->subcategory_code,
      ];

      $supplier->update($data);
      DB::commit();
      $respon = [
        'message' => "Data subcategory berhasil diubah.",
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
    $supplier = Subcategory::findOrFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'is_aktif' => 0
      ];

      $supplier->update($data);
      DB::commit();
      $respon = [
        'message' => "Data subcategory berhasil dihapus.",
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }
}
