<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pembelian extends Model
{
    use HasFactory;
    protected $table = "t_pembelian";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function supplier()
    {
        return $this->belongsTo(Supplier::class, 'supplier_id', 'id');
    }

    function detail()
    {
        return $this->hasMany(PembelianDetail::class, 'pembelian_id', 'id');
    }
}
