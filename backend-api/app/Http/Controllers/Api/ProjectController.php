<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Project;
use Illuminate\Http\Request;

class ProjectController extends Controller
{
    public function index(Request $request)
    {
        $projects = Project::where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->paginate(15);

        return response()->json($projects);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'type' => 'required|in:building,road,bridge,infrastructure',
            'address' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after:start_date',
            'budget' => 'nullable|numeric|min:0',
            'soil_type' => 'nullable|string',
            'slope_percentage' => 'nullable|numeric',
        ]);

        $project = Project::create([
            ...$validated,
            'user_id' => $request->user()->id,
            'status' => 'planning',
        ]);

        return response()->json($project, 201);
    }

    public function show(Project $project)
    {
        $this->authorize('view', $project);

        $project->load(['calculations', 'siteAnalyses', 'reports', 'machines']);

        return response()->json($project);
    }

    public function update(Request $request, Project $project)
    {
        $this->authorize('update', $project);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'type' => 'sometimes|in:building,road,bridge,infrastructure',
            'status' => 'sometimes|in:planning,active,paused,completed',
            'address' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date',
            'budget' => 'nullable|numeric|min:0',
            'soil_type' => 'nullable|string',
            'slope_percentage' => 'nullable|numeric',
        ]);

        $project->update($validated);

        return response()->json($project);
    }

    public function destroy(Project $project)
    {
        $this->authorize('delete', $project);

        $project->delete();

        return response()->json(['message' => 'Project deleted successfully']);
    }

    public function summary(Project $project)
    {
        $this->authorize('view', $project);

        return response()->json([
            'project' => $project,
            'calculations_count' => $project->calculations()->count(),
            'total_spent' => $project->calculations()->sum('total_cost'),
            'reports_count' => $project->reports()->count(),
            'machines_count' => $project->machines()->count(),
        ]);
    }
}

