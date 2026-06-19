<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'user_id',
        'name',
        'type',
        'status',
        'location',
        'address',
        'start_date',
        'end_date',
        'budget',
        'soil_type',
        'slope_percentage',
        'weather_conditions',
        'metadata',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'budget' => 'decimal:2',
        'slope_percentage' => 'decimal:2',
        'weather_conditions' => 'array',
        'metadata' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function calculations()
    {
        return $this->hasMany(MaterialCalculation::class);
    }

    public function siteAnalyses()
    {
        return $this->hasMany(SiteAnalysis::class);
    }

    public function reports()
    {
        return $this->hasMany(Report::class);
    }

    public function machines()
    {
        return $this->hasMany(Machine::class);
    }
}

