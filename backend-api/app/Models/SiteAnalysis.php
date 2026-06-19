<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SiteAnalysis extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'project_id',
        'user_id',
        'location',
        'photos',
        'soil_analysis',
        'ai_recommendations',
        'slope_data',
        'weather_data',
    ];

    protected $casts = [
        'photos' => 'array',
        'soil_analysis' => 'array',
        'ai_recommendations' => 'array',
        'slope_data' => 'array',
        'weather_data' => 'array',
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

