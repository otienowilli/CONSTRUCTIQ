<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProjectController;
use App\Http\Controllers\Api\MaterialController;
use App\Http\Controllers\Api\CalculatorController;
use App\Http\Controllers\Api\SiteAnalysisController;
use App\Http\Controllers\Api\MachineController;
use App\Http\Controllers\Api\ReportController;
use App\Http\Controllers\Api\ChatController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// Public routes
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    
    // Authentication
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
    Route::put('/user/profile', [AuthController::class, 'updateProfile']);
    
    // Projects
    Route::apiResource('projects', ProjectController::class);
    Route::get('/projects/{project}/summary', [ProjectController::class, 'summary']);
    Route::post('/projects/{project}/members', [ProjectController::class, 'addMember']);
    
    // Materials
    Route::get('/materials', [MaterialController::class, 'index']);
    Route::get('/materials/{material}', [MaterialController::class, 'show']);
    Route::get('/materials/category/{category}', [MaterialController::class, 'byCategory']);
    
    // Admin only - Material management
    Route::middleware('role:admin')->group(function () {
        Route::post('/materials', [MaterialController::class, 'store']);
        Route::put('/materials/{material}', [MaterialController::class, 'update']);
        Route::delete('/materials/{material}', [MaterialController::class, 'destroy']);
    });
    
    // Calculators
    Route::post('/calculate/concrete', [CalculatorController::class, 'concrete']);
    Route::post('/calculate/brickwork', [CalculatorController::class, 'brickwork']);
    Route::post('/calculate/plastering', [CalculatorController::class, 'plastering']);
    Route::post('/calculate/painting', [CalculatorController::class, 'painting']);
    Route::post('/calculate/roofing', [CalculatorController::class, 'roofing']);
    Route::post('/calculate/excavation', [CalculatorController::class, 'excavation']);
    Route::post('/calculate/road', [CalculatorController::class, 'road']);
    Route::post('/calculate/bitumen', [CalculatorController::class, 'bitumen']);
    Route::post('/calculate/asphalt', [CalculatorController::class, 'asphalt']);
    Route::post('/calculate/geotextile', [CalculatorController::class, 'geotextile']);
    Route::get('/calculations/history', [CalculatorController::class, 'history']);
    
    // Site Analysis
    Route::post('/site-analysis', [SiteAnalysisController::class, 'store']);
    Route::get('/site-analysis/{project}', [SiteAnalysisController::class, 'index']);
    Route::post('/site-analysis/soil', [SiteAnalysisController::class, 'analyzeSoil']);
    Route::post('/site-analysis/slope', [SiteAnalysisController::class, 'analyzeSlope']);
    
    // Machines & IoT
    Route::apiResource('machines', MachineController::class);
    Route::get('/machines/{machine}/sensors', [MachineController::class, 'sensorData']);
    Route::post('/machines/{machine}/maintenance', [MachineController::class, 'logMaintenance']);
    Route::get('/machines/{machine}/status', [MachineController::class, 'status']);

    // Machine Control (Remote Operations)
    Route::post('/machines/{machine}/command', [\App\Http\Controllers\Api\MachineControlController::class, 'sendCommand']);
    Route::get('/machines/{machine}/command-history', [\App\Http\Controllers\Api\MachineControlController::class, 'commandHistory']);
    Route::get('/machines/{machine}/control-status', [\App\Http\Controllers\Api\MachineControlController::class, 'getStatus']);
    Route::get('/machines/controllable/list', [\App\Http\Controllers\Api\MachineControlController::class, 'controllableMachines']);
    
    // Reports
    Route::apiResource('reports', ReportController::class);
    Route::post('/reports/{report}/generate-pdf', [ReportController::class, 'generatePdf']);
    Route::post('/reports/{report}/submit', [ReportController::class, 'submit']);
    Route::post('/reports/{report}/approve', [ReportController::class, 'approve']);
    
    // AI Chatbot
    Route::post('/chat', [ChatController::class, 'send']);
    Route::get('/chat/history', [ChatController::class, 'history']);
    Route::delete('/chat/clear', [ChatController::class, 'clear']);
    
    // Dashboard & Analytics
    Route::get('/dashboard/stats', function (Request $request) {
        return response()->json([
            'projects' => \App\Models\Project::where('user_id', $request->user()->id)->count(),
            'active_projects' => \App\Models\Project::where('user_id', $request->user()->id)
                ->where('status', 'active')->count(),
            'calculations' => \App\Models\MaterialCalculation::where('user_id', $request->user()->id)->count(),
            'reports' => \App\Models\Report::where('user_id', $request->user()->id)->count(),
        ]);
    });
});

// Health check
Route::get('/health', function () {
    return response()->json([
        'status' => 'ok',
        'service' => 'CONSTRUCTIQ Backend API',
        'version' => '1.0.0',
        'timestamp' => now()->toIso8601String(),
    ]);
});

