<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Webpatser\Uuid\Uuid;

class UserController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return User::orderBy('nama', 'asc')->where('is_aktif', 1)->where('hak_akses', '!=', 0)->get();
    }
    $datas = User::all();
    return ['datas' => $datas];
  }

  public function store(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'username' => [
        'required',
        Rule::unique('m_user')->where(function ($query) {
          return $query->where('is_aktif', 1);
        })
      ],
      'nama' => "required|string",
      'password' => "required",
      'hak_akses' => "required",
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
        'nama' => $request->nama,
        'username' => $request->username,
        'password' => bcrypt($request->password),
        'hak_akses' => $request->hak_akses
      ];

      User::create($data);
      DB::commit();
      $respon = [
        'message' => "Data user berhasil ditambah",
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
      'username' => [
        'required',
        Rule::unique('m_user')->where(function ($query) {
          return $query->where('is_aktif', 1);
        })->ignore($id, 'id')
      ],
      'nama' => "required|string",
      'hak_akses' => "required",
    ], [
      'unique' => 'Field :attribute harus unik!.',
      'required' => 'Field :attribute harus diisi!.',
      'string' => 'Field :attribute berupa string!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $user = User::findorFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'nama' => $request->nama,
        'username' => $request->username,
        'password' => bcrypt($request->password),
        'hak_akses' => $request->hak_akses
      ];

      $user->update($data);
      DB::commit();
      $respon = [
        'message' => "Data user berhasil diubah",
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
    $user = User::findorFail($id);
    DB::beginTransaction();
    try {
      $data = [
        'is_aktif' => 0
      ];

      $user->update($data);
      DB::commit();
      $respon = [
        'message' => "Data user berhasil dihapus",
      ];

      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }
}
