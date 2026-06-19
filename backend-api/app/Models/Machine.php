<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Machine extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'name',
        'type',
        'model',
        'serial_number',
        'status',
        'project_id',
        'location',
        'specifications',
        'last_maintenance',
        'next_maintenance',
    ];

    protected $casts = [
        'specifications' => 'array',
        'last_maintenance' => 'datetime',
        'next_maintenance' => 'datetime',
    ];

    public function project()
    {
        return $this->belongsTo(Project::class);
    }

    public function sensorLogs()
    {
        return $this->hasMany(SensorLog::class);
    }
}

