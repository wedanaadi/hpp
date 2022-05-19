<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JurnalUmum extends Model
{
    use HasFactory;
    protected $table = "t_jurnal_umum";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function akuns()
    {
        return $this->belongsTo(Akun::class, 'akun', 'id');
    }
}
