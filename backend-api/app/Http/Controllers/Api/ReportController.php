<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Report;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $reports = Report::where('user_id', $request->user()->id)
            ->with('project:id,name')
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json($reports);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'title' => 'required|string|max:255',
            'type' => 'required|in:daily,weekly,monthly,final',
            'content' => 'required|array',
        ]);

        $report = Report::create([
            ...$validated,
            'user_id' => $request->user()->id,
            'status' => 'draft',
        ]);

        return response()->json($report, 201);
    }

    public function show(Report $report)
    {
        $report->load('project');
        return response()->json($report);
    }

    public function update(Request $request, Report $report)
    {
        $validated = $request->validate([
            'title' => 'sometimes|string|max:255',
            'content' => 'sometimes|array',
            'status' => 'sometimes|in:draft,submitted,approved',
        ]);

        $report->update($validated);
        return response()->json($report);
    }

    public function destroy(Report $report)
    {
        $report->delete();
        return response()->json(['message' => 'Report deleted successfully']);
    }

    public function generatePdf(Report $report)
    {
        // PDF generation logic would go here
        return response()->json([
            'message' => 'PDF generation initiated',
            'pdf_url' => 'https://example.com/reports/' . $report->id . '.pdf',
        ]);
    }

    public function submit(Report $report)
    {
        $report->update(['status' => 'submitted']);
        return response()->json(['message' => 'Report submitted successfully']);
    }

    public function approve(Report $report)
    {
        $report->update(['status' => 'approved']);
        return response()->json(['message' => 'Report approved successfully']);
    }
}

