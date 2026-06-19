<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\MaterialCalculation;
use App\Services\CalculatorService;
use Illuminate\Http\Request;

class CalculatorController extends Controller
{
    protected $calculator;

    public function __construct(CalculatorService $calculator)
    {
        $this->calculator = $calculator;
    }

    /**
     * Calculate concrete requirements
     */
    public function concrete(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'width' => 'required|numeric|min:0',
            'height' => 'required|numeric|min:0',
            'concrete_grade' => 'nullable|in:C15,C20,C25,C30',
        ]);

        $results = $this->calculator->calculateConcrete($validated);

        // Save calculation
        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'concrete',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => $results['materials'],
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate brickwork requirements
     */
    public function brickwork(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'height' => 'required|numeric|min:0',
            'thickness' => 'nullable|numeric|min:0',
            'brick_type' => 'nullable|in:clay,concrete',
        ]);

        $results = $this->calculator->calculateBrickwork($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'brickwork',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => $results['materials'],
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate plastering requirements
     */
    public function plastering(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'area' => 'required|numeric|min:0',
            'thickness' => 'nullable|numeric|min:0',
            'ratio' => 'nullable|string',
        ]);

        $results = $this->calculator->calculatePlastering($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'plastering',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => $results['materials'],
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate painting requirements
     */
    public function painting(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'area' => 'required|numeric|min:0',
            'coats' => 'nullable|integer|min:1',
            'paint_type' => 'nullable|string',
        ]);

        $results = $this->calculator->calculatePainting($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'painting',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => $results['materials'],
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate excavation requirements
     */
    public function excavation(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'width' => 'required|numeric|min:0',
            'depth' => 'required|numeric|min:0',
        ]);

        $results = $this->calculator->calculateExcavation($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'excavation',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => [],
            'total_cost' => 0,
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate road construction requirements
     */
    public function road(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'width' => 'required|numeric|min:0',
            'layers' => 'nullable|array',
        ]);

        $results = $this->calculator->calculateRoad($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'road',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => $results['materials'],
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate roofing requirements
     */
    public function roofing(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'area' => 'required|numeric|min:0',
            'roof_type' => 'nullable|string',
            'pitch' => 'nullable|numeric|min:0|max:90',
        ]);

        $results = $this->calculator->calculateRoofing($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'roofing',
            'inputs' => $validated,
            'results' => $results,
            'materials_used' => [],
            'total_cost' => 0,
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate bitumen requirements
     */
    public function bitumen(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'width' => 'required|numeric|min:0',
            'layer_thickness' => 'nullable|numeric|min:0',
            'bitumen_grade' => 'nullable|in:80/100,60/70,40/50,prime_coat,tack_coat',
        ]);

        $results = $this->calculator->calculateBitumen($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'bitumen',
            'inputs' => $validated,
            'results' => $results,
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate asphalt requirements
     */
    public function asphalt(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'width' => 'required|numeric|min:0',
            'thickness' => 'nullable|numeric|min:0',
            'asphalt_type' => 'nullable|in:AC14,AC20,DBM,BC,SMA',
        ]);

        $results = $this->calculator->calculateAsphalt($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'asphalt',
            'inputs' => $validated,
            'results' => $results,
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Calculate geotextile requirements
     */
    public function geotextile(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'nullable|exists:projects,id',
            'length' => 'required|numeric|min:0',
            'width' => 'required|numeric|min:0',
            'geotextile_type' => 'nullable|in:woven,non-woven',
            'overlap_percentage' => 'nullable|numeric|min:0|max:50',
        ]);

        $results = $this->calculator->calculateGeotextile($validated);

        $calculation = MaterialCalculation::create([
            'project_id' => $validated['project_id'] ?? null,
            'user_id' => $request->user()->id,
            'calculation_type' => 'geotextile',
            'inputs' => $validated,
            'results' => $results,
            'total_cost' => $results['total_cost'],
        ]);

        return response()->json([
            'calculation_id' => $calculation->id,
            'results' => $results,
        ]);
    }

    /**
     * Get calculation history
     */
    public function history(Request $request)
    {
        $calculations = MaterialCalculation::where('user_id', $request->user()->id)
            ->with('project:id,name')
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json($calculations);
    }
}


