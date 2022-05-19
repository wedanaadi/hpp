<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProduksiDetail extends Model
{
    use HasFactory;
    protected $table = "t_produksi_detail";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function barang()
    {
        return $this->belongsTo(Barang::class, 'bahan_id', 'id');
    }
}
