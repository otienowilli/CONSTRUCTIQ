<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MachineCommand extends Model
{
    use HasFactory, HasUuids;

    protected $fillable = [
        'machine_id',
        'user_id',
        'command',
        'parameters',
        'status',
        'executed_at',
        'response',
    ];

    protected $casts = [
        'parameters' => 'array',
        'response' => 'array',
        'executed_at' => 'datetime',
    ];

    public function machine()
    {
        return $this->belongsTo(Machine::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
