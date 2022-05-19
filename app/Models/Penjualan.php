<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Penjualan extends Model
{
    use HasFactory;
    protected $table = "t_penjualan";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function detail()
    {
        return $this->hasMany(PenjualanDetail::class, 'penjualan_id', 'id');
    }
}
