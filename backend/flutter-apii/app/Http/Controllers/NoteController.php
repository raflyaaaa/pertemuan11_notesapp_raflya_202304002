<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Note;

class NoteController extends Controller
{
    public function index(Request $request)
    {
        return $request->user()->notes;
    }

    public function store(Request $request)
    {
        return Note::create([
            'user_id' => $request->user()->id,
            'title' => $request->title,
            'content' => $request->content,
        ]);
    }

    public function update(Request $request, $id)
    {
        $note = Note::where('user_id', $request->user()->id)->findOrFail($id);

        $note->update([
            'title' => $request->title,
            'content' => $request->content,
        ]);

        return $note;
    }

    public function destroy(Request $request, $id)
    {
        $note = Note::where('user_id', $request->user()->id)->findOrFail($id);
        $note->delete();

        return response()->json(['message' => 'Deleted']);
    }
    
}
