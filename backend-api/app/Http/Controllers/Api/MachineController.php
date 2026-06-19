<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Machine;
use App\Models\SensorLog;
use Illuminate\Http\Request;

class MachineController extends Controller
{
    public function index()
    {
        $machines = Machine::with('project:id,name')->get();
        return response()->json($machines);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'type' => 'required|in:excavator,mixer,crane,bulldozer,compactor,other',
            'model' => 'nullable|string',
            'serial_number' => 'nullable|string|unique:machines',
            'project_id' => 'nullable|exists:projects,id',
        ]);

        $machine = Machine::create($validated);
        return response()->json($machine, 201);
    }

    public function show(Machine $machine)
    {
        $machine->load(['project', 'sensorLogs' => function ($query) {
            $query->orderBy('timestamp', 'desc')->limit(100);
        }]);

        return response()->json($machine);
    }

    public function update(Request $request, Machine $machine)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'status' => 'sometimes|in:active,idle,maintenance,offline',
            'project_id' => 'nullable|exists:projects,id',
        ]);

        $machine->update($validated);
        return response()->json($machine);
    }

    public function sensorData(Machine $machine)
    {
        $logs = SensorLog::where('machine_id', $machine->id)
            ->orderBy('timestamp', 'desc')
            ->limit(1000)
            ->get();

        return response()->json($logs);
    }

    public function status(Machine $machine)
    {
        $latestSensor = SensorLog::where('machine_id', $machine->id)
            ->orderBy('timestamp', 'desc')
            ->first();

        return response()->json([
            'machine' => $machine,
            'latest_sensor_reading' => $latestSensor,
            'status' => $machine->status,
        ]);
    }

    public function logMaintenance(Request $request, Machine $machine)
    {
        $validated = $request->validate([
            'notes' => 'required|string',
            'next_maintenance' => 'nullable|date',
        ]);

        $machine->update([
            'last_maintenance' => now(),
            'next_maintenance' => $validated['next_maintenance'] ?? now()->addMonths(3),
            'status' => 'maintenance',
        ]);

        return response()->json([
            'message' => 'Maintenance logged successfully',
            'machine' => $machine,
        ]);
    }
}

