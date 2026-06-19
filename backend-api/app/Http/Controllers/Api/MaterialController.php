<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Material;
use Illuminate\Http\Request;

class MaterialController extends Controller
{
    public function index(Request $request)
    {
        $query = Material::active();

        if ($request->has('search')) {
            $query->where('name', 'LIKE', '%' . $request->search . '%');
        }

        if ($request->has('category')) {
            $query->byCategory($request->category);
        }

        $materials = $query->orderBy('name')->paginate(50);

        return response()->json($materials);
    }

    public function show(Material $material)
    {
        return response()->json($material);
    }

    public function byCategory(string $category)
    {
        $materials = Material::active()
            ->byCategory($category)
            ->orderBy('name')
            ->get();

        return response()->json($materials);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'category' => 'required|in:civil,roads,finishing,plumbing,electrical,structural',
            'unit' => 'required|string|max:50',
            'base_price' => 'required|numeric|min:0',
            'description' => 'nullable|string',
            'specifications' => 'nullable|array',
            'image_url' => 'nullable|url',
        ]);

        $material = Material::create($validated);

        return response()->json($material, 201);
    }

    public function update(Request $request, Material $material)
    {
        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'category' => 'sometimes|in:civil,roads,finishing,plumbing,electrical,structural',
            'unit' => 'sometimes|string|max:50',
            'base_price' => 'sometimes|numeric|min:0',
            'description' => 'nullable|string',
            'specifications' => 'nullable|array',
            'image_url' => 'nullable|url',
            'is_active' => 'sometimes|boolean',
        ]);

        $material->update($validated);

        return response()->json($material);
    }

    public function destroy(Material $material)
    {
        $material->update(['is_active' => false]);

        return response()->json(['message' => 'Material deactivated successfully']);
    }
}

