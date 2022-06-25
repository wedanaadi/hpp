<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PenjualanDetail extends Model
{
    use HasFactory;
    protected $table = "t_penjualan_detail";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function barang()
    {
        return $this->hasOne(Barang::class, 'id', 'barang_id');
    }
}
