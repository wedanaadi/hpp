<?php

namespace App\Http\Controllers;

use App\Libraries\Fungsi;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Symfony\Component\HttpFoundation\Response;

class AuthController extends Controller
{
  public function login(Request $request)
  {
    $validator = Validator::make($request->all(), [
      'username' => 'required',
      'password' => 'required',
    ], [
      'required' => 'Field :attribute harus diisi!.',
    ]);

    if ($validator->fails()) {
      return response()->json($validator->errors(), Response::HTTP_UNPROCESSABLE_ENTITY);
    }

    $user = User::where('username', $request->username)
      ->where('is_aktif', 1)->first();
    if (!$user || !Hash::check($request->password, $user->password)) {
      return response([
        'success'   => false,
        'message' => ['These credentials do not match our records.']
      ], Response::HTTP_OK);
    }

    $token = $user->createToken('ApiToken')->plainTextToken;

    $response = [
      'success'   => true,
      'user'      => $user,
      'token'     => $token
    ];

    return response($response, Response::HTTP_CREATED);
  }

  public function user(Request $request)
  {
    return User::find($request->id);
  }

  public function setting()
  {
    return DB::table('setting_sistem')->first();
  }

  public function logout(Request $request)
  {
    auth()->logout();
    $token = DB::table('personal_access_tokens')->where('tokenable_id', $request->id);
    $token->delete();
    DB::statement("ALTER TABLE `personal_access_tokens`  AUTO_INCREMENT = 1");
    return response()->json([
      'success'    => true
    ], Response::HTTP_OK);
  }

  public function update()
  {
    $u = User::find('9992c600-af5d-11ec-ae41-150f7c04192b');
    $u->update([
      'username' => 'adi',
      'password' => bcrypt('admin')
    ]);
  }

  public function chart()
  {
    $dataset = [];
    for ($i = 1; $i < 13; $i++) {
      if ($i < 10) {
        $i = "0" . $i;
      }
      $date = date('Y') . '-' . $i;
      $datas = DB::select("select DATE_format(tanggal,'%m') as 'bln', ifnull(sum(jumlah_trx),0) as 'data' from t_penjualan
              where DATE_format(tanggal,'%Y-%m') = '$date'");
      array_push($dataset, $datas[0]->data);
    }
    return ['dataSet' => $dataset, 'year' => date('Y')];
  }
}
