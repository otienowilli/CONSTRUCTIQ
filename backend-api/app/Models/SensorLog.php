<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SensorLog extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'machine_id',
        'sensor_type',
        'value',
        'unit',
        'timestamp',
        'metadata',
    ];

    protected $casts = [
        'value' => 'decimal:2',
        'timestamp' => 'datetime',
        'metadata' => 'array',
    ];

    public function machine()
    {
        return $this->belongsTo(Machine::class);
    }
}

