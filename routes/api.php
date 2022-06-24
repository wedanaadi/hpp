<?php

use App\Http\Controllers\AkunController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BarangController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\JurnalController;
use App\Http\Controllers\MenuController;
use App\Http\Controllers\PembelianController;
use App\Http\Controllers\PenjualanController;
use App\Http\Controllers\ProduksiController;
use App\Http\Controllers\SubcategoryController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\UserController;
use App\Models\Pembelian;
use App\Models\Penjualan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/login', [AuthController::class, 'login'])->name('login');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
Route::get('/su', [AuthController::class, 'update']);
Route::get('/chart', [AuthController::class, 'chart']);

Route::resource('supplier', SupplierController::class);
Route::resource('user', UserController::class);
Route::resource('akun', AkunController::class);
Route::resource('category', CategoryController::class);
Route::get('/barang-baku', [BarangController::class, 'brg_baku'])->name('list.barangbaku');
Route::get('/barang-jual', [BarangController::class, 'brg_jual'])->name('list.barangjual');
Route::get('/barang-jadi', [BarangController::class, 'brg_jadi'])->name('list.barangjadi');
Route::get('barang-hpp', [ProduksiController::class, 'brg_hpp'])->name('list.baranghpp');
Route::get('/bahan-produksi', [BarangController::class, 'brg_produksi'])->name('list.barangproduksi');
Route::get('/pembelian/cetak', [PembelianController::class, 'report'])->name('list.pembelian.report');
Route::get('/penjualan/cetak', [PenjualanController::class, 'report'])->name('list.penjualan.report');
Route::get('/labarugi/cetak', [JurnalController::class, 'report_lb'])->name('list.lb.report');
Route::get('/neraca/cetak', [JurnalController::class, 'report_neraca'])->name('list.neraca.report');
Route::get('/stock/cetak', [BarangController::class, 'report'])->name('list.stock.report');
Route::get('/hpp/cetak', [ProduksiController::class, 'report'])->name('list.hpp.report');
Route::resource('barang', BarangController::class);
Route::resource('menu', MenuController::class);
Route::resource('subcategory', SubcategoryController::class);
Route::resource('pembelian', PembelianController::class);
Route::resource('penjualan', PenjualanController::class);
Route::resource('produksi', ProduksiController::class);
Route::resource('jurnal', JurnalController::class);
Route::get('/unit', [BarangController::class, 'unit'])->name('barang.unit.list');
Route::post('/barangUpdate/{id}', [BarangController::class, 'update'])->name('barang.update.fixed');
Route::post('/menuUpdate/{id}', [MenuController::class, 'update'])->name('menu.update.fixed');
Route::post('/unit', [BarangController::class, 'saveUnit'])->name('barang.unit.save');
Route::get('/subklasifikasi', [AkunController::class, 'subklasifikasi'])->name('akun.subklasifikasi.list');
Route::post('/akun/sub', [AkunController::class, 'save_sub'])->name('akun.subklasifikasi.save');
