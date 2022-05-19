<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Unit extends Model
{
    use HasFactory;
    use HasFactory;
    protected $table = "m_satuan";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;
}
