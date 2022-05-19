<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Barang extends Model
{
    use HasFactory;
    protected $table = "m_barang";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function unit()
    {
        return $this->belongsTo(Unit::class, 'satuan_id', 'id');
    }

    function subcategory()
    {
        return $this->belongsTo(Subcategory::class, 'subcategory_id', 'id');
    }
}
