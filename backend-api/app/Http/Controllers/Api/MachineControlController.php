<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Machine;
use App\Models\MachineCommand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class MachineControlController extends Controller
{
    /**
     * Send command to machine (start, stop, pause, resume)
     */
    public function sendCommand(Request $request, $machineId)
    {
        $validated = $request->validate([
            'command' => 'required|in:start,stop,pause,resume,emergency_stop',
            'parameters' => 'nullable|array',
        ]);

        $machine = Machine::findOrFail($machineId);

        // Check if machine supports remote control
        if (!$machine->can_remote_control) {
            return response()->json([
                'error' => 'This machine does not support remote control'
            ], 403);
        }

        // Create command record
        $machineCommand = MachineCommand::create([
            'machine_id' => $machine->id,
            'user_id' => $request->user()->id,
            'command' => $validated['command'],
            'parameters' => $validated['parameters'] ?? null,
            'status' => 'pending',
        ]);

        // Send command to IoT Gateway via MQTT topic
        try {
            $response = Http::post(env('IOT_GATEWAY_URL', 'http://iot-gateway:8003') . '/machine/command', [
                'machine_id' => $machine->id,
                'mqtt_topic' => $machine->mqtt_topic,
                'plc_address' => $machine->plc_address,
                'command' => $validated['command'],
                'parameters' => $validated['parameters'] ?? [],
            ]);

            if ($response->successful()) {
                $machineCommand->update([
                    'status' => 'sent',
                    'executed_at' => now(),
                    'response' => $response->json(),
                ]);

                // Update machine status based on command
                $this->updateMachineStatus($machine, $validated['command']);

                return response()->json([
                    'message' => 'Command sent successfully',
                    'command_id' => $machineCommand->id,
                    'status' => $machineCommand->status,
                    'response' => $response->json(),
                ]);
            } else {
                $machineCommand->update([
                    'status' => 'failed',
                    'response' => ['error' => 'Failed to send command'],
                ]);

                return response()->json([
                    'error' => 'Failed to send command to machine'
                ], 500);
            }
        } catch (\Exception $e) {
            $machineCommand->update([
                'status' => 'error',
                'response' => ['error' => $e->getMessage()],
            ]);

            return response()->json([
                'error' => 'Error communicating with IoT Gateway: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get machine status
     */
    public function getStatus($machineId)
    {
        $machine = Machine::with('latestSensorLogs')->findOrFail($machineId);

        return response()->json([
            'machine' => $machine,
            'sensor_data' => $machine->latestSensorLogs,
        ]);
    }

    /**
     * Get command history for a machine
     */
    public function commandHistory($machineId)
    {
        $commands = MachineCommand::where('machine_id', $machineId)
            ->with('user:id,name,email')
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json($commands);
    }

    /**
     * Update machine status based on command
     */
    private function updateMachineStatus(Machine $machine, string $command)
    {
        $statusMap = [
            'start' => 'running',
            'stop' => 'idle',
            'pause' => 'paused',
            'resume' => 'running',
            'emergency_stop' => 'offline',
        ];

        if (isset($statusMap[$command])) {
            $machine->update(['status' => $statusMap[$command]]);
        }
    }

    /**
     * Get all controllable machines
     */
    public function controllableMachines()
    {
        $machines = Machine::where('can_remote_control', true)
            ->with('project:id,name')
            ->get();

        return response()->json($machines);
    }
}
