<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;
    protected $table = "m_category";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;
}