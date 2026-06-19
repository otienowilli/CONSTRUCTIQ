<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SiteAnalysis;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class SiteAnalysisController extends Controller
{
    public function index($projectId)
    {
        $analyses = SiteAnalysis::where('project_id', $projectId)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($analyses);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'photos' => 'nullable|array',
            'photos.*' => 'url',
            'location' => 'nullable|array',
        ]);

        $analysis = SiteAnalysis::create([
            ...$validated,
            'user_id' => $request->user()->id,
        ]);

        return response()->json($analysis, 201);
    }

    public function analyzeSoil(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'image' => 'required|url',
        ]);

        // Call AI Engine for soil analysis
        $aiEngineUrl = env('AI_ENGINE_URL');
        
        try {
            $response = Http::timeout(60)->post("{$aiEngineUrl}/analyze/soil", [
                'image_url' => $validated['image'],
            ]);

            $soilData = $response->json();
        } catch (\Exception $e) {
            $soilData = ['error' => 'AI analysis failed'];
        }

        return response()->json($soilData);
    }

    public function analyzeSlope(Request $request)
    {
        $validated = $request->validate([
            'rise' => 'required|numeric',
            'run' => 'required|numeric',
        ]);

        $slope = ($validated['rise'] / $validated['run']) * 100;

        return response()->json([
            'slope_percentage' => round($slope, 2),
            'slope_ratio' => "1:" . round($validated['run'] / $validated['rise'], 2),
            'recommendation' => $slope > 15 ? 'Steep slope - requires special foundation' : 'Normal slope',
        ]);
    }
}

