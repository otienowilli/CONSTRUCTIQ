<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ChatMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class ChatController extends Controller
{
    public function send(Request $request)
    {
        $validated = $request->validate([
            'message' => 'required|string',
            'project_id' => 'nullable|exists:projects,id',
        ]);

        // Call AI Engine
        $aiEngineUrl = config('services.ai_engine.url', env('AI_ENGINE_URL'));
        
        try {
            $response = Http::timeout(30)->post("{$aiEngineUrl}/chat", [
                'message' => $validated['message'],
                'user_id' => $request->user()->id,
                'project_id' => $validated['project_id'] ?? null,
            ]);

            $aiResponse = $response->json()['response'] ?? 'Sorry, I could not process your request.';
        } catch (\Exception $e) {
            $aiResponse = 'AI service is currently unavailable. Please try again later.';
        }

        // Save chat message
        $chat = ChatMessage::create([
            'user_id' => $request->user()->id,
            'project_id' => $validated['project_id'] ?? null,
            'message' => $validated['message'],
            'response' => $aiResponse,
            'context' => [
                'timestamp' => now()->toIso8601String(),
            ],
        ]);

        return response()->json([
            'message' => $validated['message'],
            'response' => $aiResponse,
            'chat_id' => $chat->id,
        ]);
    }

    public function history(Request $request)
    {
        $messages = ChatMessage::where('user_id', $request->user()->id)
            ->when($request->project_id, function ($query) use ($request) {
                return $query->where('project_id', $request->project_id);
            })
            ->orderBy('created_at', 'desc')
            ->paginate(50);

        return response()->json($messages);
    }

    public function clear(Request $request)
    {
        ChatMessage::where('user_id', $request->user()->id)->delete();

        return response()->json(['message' => 'Chat history cleared']);
    }
}

