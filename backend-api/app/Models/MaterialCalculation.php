<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MaterialCalculation extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'project_id',
        'user_id',
        'calculation_type',
        'inputs',
        'results',
        'materials_used',
        'total_cost',
        'notes',
    ];

    protected $casts = [
        'inputs' => 'array',
        'results' => 'array',
        'materials_used' => 'array',
        'total_cost' => 'decimal:2',
    ];

    public function project()
    {
        return $this->belongsTo(Project::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

