<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DataController extends Controller
{
    public function index()
    {
        $data = [
            ['id' => 1, 'name' => 'John Doe', 'price' => 100.00],
            ['id' => 2, 'name' => 'Alex Bidin', 'price' => 150.00]
        ];

        return response()->json([
            'status' => 'success',
            'data' => $data
        ]);
    }
}
