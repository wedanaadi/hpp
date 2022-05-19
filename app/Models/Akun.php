<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Akun extends Model
{
    use HasFactory;
    protected $table = "m_akun";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;
}
