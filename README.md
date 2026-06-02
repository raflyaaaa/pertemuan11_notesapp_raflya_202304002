🚀 Project Overview

Notes App adalah aplikasi fullstack sederhana untuk membuat, membaca, mengedit, dan menghapus catatan. Backend menggunakan Laravel API (JWT/Sanctum authentication) dan frontend menggunakan Flutter.

🎯 Features
🔐 Authentication
Login user
Token-based authentication
📝 Notes Management
Create note
Read all notes
Update note
Delete note
🏗️ Tech Stack
Backend
Laravel
MySQL
Sanctum / JWT Auth
REST API
Frontend
Flutter
Provider (state management)
HTTP package
📁 Project Structure
backend/   -> Laravel API
frontend/  -> Flutter App
screenshots/ -> UI documentation
🔌 API Endpoints
Auth
POST /api/login
POST /api/register
Notes
GET    /api/notes
POST   /api/notes
PUT    /api/notes/{id}
DELETE /api/notes/{id}
📱 App Flow
User login
Token disimpan di Flutter
Fetch notes dari API
User bisa:
tambah note
edit note
hapus note
Data langsung sinkron ke database
📸 Screenshots
Login Page

Home Page

Create Note

Edit Note

⚙️ Setup Project
Backend (Laravel)
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
Frontend (Flutter)
cd frontend
flutter pub get
flutter run
🧪 Testing
API diuji menggunakan Postman
Flutter diuji di emulator Android
📌 Notes
Backend harus jalan sebelum Flutter
Pastikan token dikirim di header:
Authorization: Bearer <token>
👨‍💻 Author
Fullstack Project (Laravel + Flutter)
Student Software Engineering
