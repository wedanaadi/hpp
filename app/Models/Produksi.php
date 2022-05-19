<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Produksi extends Model
{
    use HasFactory;
    protected $table = "t_produksi";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function detail()
    {
        return $this->hasMany(ProduksiDetail::class, 'produksi_id', 'id');
    }

    function menu()
    {
        return $this->belongsTo(Barang::class, 'barang_id', 'id');
    }
}
