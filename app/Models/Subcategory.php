<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subcategory extends Model
{
    use HasFactory;
    protected $table = "m_subcategory";
    protected $guarded = [];
    public $timestamps = false;
    public $incrementing = false;

    function category()
    {
        return $this->belongsTo(Category::class);
    }
}
