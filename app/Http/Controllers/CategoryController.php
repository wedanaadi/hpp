<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Webpatser\Uuid\Uuid;

class CategoryController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return Category::orderBy('category_name', 'asc')->where('is_aktif', 1)->get();
    }
    $datas = Category::all();
    return ['datas' => $datas];
  }

  public function store(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'category_name' => "required|string",
      'category_code' => "required|numeric|gt:0",
    ], [
      'required' => 'Field :attribute harus diisi!.',
      'string' => 'Field :attribute berupa string!.',
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
        'category_name' => $request->category_name,
        'code_category' => $request->category_code,
      ];

      Category::create($data);
      DB::commit();
      $respon = [
        'message' => "Data category berhasil disimpan.",
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
      'category_name' => "required|string",
      'category_code' => "required|numeric|gt:0",
    ], [
      'required' => 'Field :attribute harus diisi!.',
      'string' => 'Field :attribute berupa string!.',
      'numeric' => 'Field :attribute berupa angka!.',
      'gt' => 'Field :attribute harus lebih dari 0!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $supplier = Category::findOrFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'category_name' => $request->category_name,
        'code_category' => $request->category_code,
      ];

      $supplier->update($data);
      DB::commit();
      $respon = [
        'message' => "Data category berhasil diubah.",
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
    $supplier = Category::findOrFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'is_aktif' => 0
      ];

      $supplier->update($data);
      DB::commit();
      $respon = [
        'message' => "Data category berhasil dihapus.",
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }
}
