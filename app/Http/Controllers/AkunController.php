<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\Akun;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Webpatser\Uuid\Uuid;

class AkunController extends Controller
{
  public function index(Request $request)
  {
    if ($request->input('showdata')) {
      return Akun::orderBy('id', 'asc')->where('is_aktif', 1)->get();
    }

    $datas = Akun::all();
    return ['data' => $datas];
  }

  public function subklasifikasi()
  {
    return DB::table('m_subklasifikasi')->where('is_aktif', '1')->select('kode_subklasifikasi')->get();
  }

  public function store(Request $request)
  {
    $validator = Validator::make(
      $request->all(),
      [
        'desc' => 'required',
        'kode_sub' => 'required',
        'akuntype' => 'required',
      ],
      [
        'desc.required' => 'Field Description harus diisi!',
        'kode_sub.required' => 'Field Kode Subklasifikasi harus diisi!',
        'akuntype.required' => 'Field Account Type harus diisi!',
      ]
    );

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    DB::beginTransaction();
    try {
      $lastKode = Akun::select(DB::raw('MAX(kode_sub) AS kode'))
        ->where(DB::raw('SUBSTR(kode_sub,1,4)'), $request->kode_sub)
        ->where('is_aktif', 1)
        ->first();
      $newKode = Fungsi::numberDash($lastKode->kode, 4, 5, $request->kode_sub, '-',);
      $data = [
        'id' => Uuid::generate()->string,
        'kode_sub' => $newKode,
        'nama_akun' => $request->desc,
        'type' => $request->akuntype,
        'is_aktif' => '1',
        'sistem' => '0'
      ];

      Akun::create($data);
      DB::commit();
      $respon = [
        'message' => "Data Akun berhasil disimpan.",
        'icon' => 'success',
        'data' => $data
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ['icon' => 'error', "error" => $e->getMessage()];
    }
  }

  public function update(Request $request, $id)
  {
    $validator = Validator::make(
      $request->all(),
      [
        'desc' => 'required',
        'kode_sub' => 'required',
        'akuntype' => 'required',
      ],
      [
        'desc.required' => 'Field Description harus diisi!',
        'kode_sub.required' => 'Field Kode Subklasifikasi harus diisi!',
        'akuntype.required' => 'Field Account Type harus diisi!',
      ]
    );

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    $akun = Akun::findOrFail($id);
    DB::beginTransaction();
    try {
      $lastKode = Akun::select(DB::raw('MAX(kode_sub) AS kode'))
        ->where(DB::raw('SUBSTR(kode_sub,1,4)'), $request->kode_sub)
        ->where('is_aktif', 1)
        ->first();
      $newKode = Fungsi::numberDash($lastKode->kode, 4, 5, $request->kode_sub, '-',);
      $data = [
        'kode_sub' => $newKode,
        'nama_akun' => $request->desc,
        'type' => $request->akuntype,
        'is_aktif' => '1',
        'sistem' => '0'
      ];

      $akun->update($data);
      DB::commit();
      $respon = [
        'message' => "Data Akun berhasil diubah.",
        'icon' => 'success',
        'data' => $data
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ['icon' => 'error', "error" => $e->getMessage()];
    }
  }

  public function destroy($id)
  {
    $akun = Akun::findOrFail($id);
    DB::beginTransaction();
    try {
      $akun->update(['is_aktif' => "0"]);
      DB::commit();
      $respon = [
        'message' => "Data Akun berhasil dihapus.",
        'icon' => 'success',
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ['icon' => 'error', "error" => $e->getMessage()];
    }
  }

  public function save_sub(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'kode_subklasifikasi' => [
        'required',
        'max:4',
        Rule::unique('m_subklasifikasi')->where(function ($query) {
          return $query->where('is_aktif', 1);
        })
      ],
    ], [
      'unique' => 'Field :attribute sudah ada!.',
      'required' => 'Field :attribute harus diisi!.',
      'max' => 'Field :attribute maksimal 4 caracter!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), 422);
    }

    DB::beginTransaction();
    try {
      $data = [
        'id' => Uuid::generate()->string,
        'kode_subklasifikasi' => $request->kode_subklasifikasi,
        'is_aktif' => 1,
      ];
      DB::table('m_subklasifikasi')->insert($data);
      DB::commit();
      $sub  = DB::table('m_subklasifikasi')->where('is_aktif', '1')->select('kode_subklasifikasi')->get();
      $respon = [
        'message' => "Data Subklasifikasi berhasil disimpan.",
        'subklasifikasi' => $sub
      ];
      return response()->json($respon, 201);
    } catch (\Exception $e) {
      DB::rollback();
      return ["error" => $e->getMessage()];
    }
  }
}
