# 📝 Notes App (Fullstack Flutter + Laravel)

## 🚀 Project Name
**Notes App with Authentication (Mini Project A)**

## 🧠 Stack Teknologi
- Frontend: Flutter (Dart)
- Backend: Laravel REST API
- Database: MySQL
- Auth: JWT / Sanctum Token
- State Management: Provider

---

# 🎯 1. Objective (Tujuan)
Aplikasi Notes App ini dibuat untuk memungkinkan user menyimpan catatan pribadi secara aman dengan sistem autentikasi. Setiap user memiliki data catatan yang terisolasi (private per user).

---

# 🔄 2. User Flow (Alur Pengguna)

1. User membuka aplikasi
2. User melakukan Login / Register
3. Sistem melakukan validasi token (session check)
4. Jika valid → masuk ke Dashboard
5. Dashboard menampilkan daftar notes milik user
6. User dapat:
   - Membuat note baru
   - Melihat daftar note
   - Mengedit note
   - Menghapus note
7. Logout menghapus session/token

---

# ⚙️ 3. Functional Requirements

| Modul | ID | Fitur | Deskripsi | Prioritas |
|------|----|-------|------------|-----------|
| Auth | FE-01 | Register Account | Membuat akun user baru | P0 |
| Auth | FE-02 | Login User | Login dengan email & password | P0 |
| Auth | FE-03 | Logout Session | Menghapus token & logout | P0 |
| Auth | FE-04 | Auto Login Guard | Auto login jika token masih valid | P0 |
| Notes | FE-05 | View Notes List | Menampilkan semua notes user | P0 |
| Notes | FE-06 | Create Note | Menambah catatan baru | P0 |
| Notes | FE-07 | Delete Note | Menghapus catatan | P1 |
| Notes | FE-08 | Edit Note | Mengedit catatan | P1 |

---

# 🏗️ 4. Technical Architecture

## Frontend (Flutter)
- Flutter SDK
- Dart
- Provider (State Management)
- HTTP package
- Secure Storage (token JWT)

## Backend (Laravel)
- Laravel Framework
- REST API
- MySQL Database
- Authentication (Sanctum / JWT)

---

# 📡 5. API Endpoints

## Auth
POST /api/register  
POST /api/login  
POST /api/logout  

## Notes
GET /api/notes  
POST /api/notes  
PUT /api/notes/{id}  
DELETE /api/notes/{id}

---

# 📱 6. App Features

## Authentication
- Login user
- Register user
- Token-based session

## Notes Management
- Create note
- Read notes (per user)
- Update note
- Delete note

---

# 📸 7. Screenshots

Tambahkan screenshot aplikasi di folder:
screenshots/

Contoh:
- Login Page
- Dashboard Notes
- Create Note Modal
- Edit Note Modal
- Delete Action

---

# 🧪 8. Testing

- API testing: Postman
- Frontend testing: Emulator / Physical device

---

# ⚙️ 9. Setup Project

## Backend (Laravel)
cd backend  
composer install  
cp .env.example .env  
php artisan key:generate  
php artisan migrate  
php artisan serve  

## Frontend (Flutter)
cd frontend  
flutter pub get  
flutter run  

---

# 🔐 10. Security Notes

Semua request notes wajib menggunakan:
Authorization: Bearer <token>

Data notes hanya bisa diakses oleh user pemiliknya.

---

# 📌 11. Out of Scope

- Reset password via email  
- Rich text editor  
- Kategori / tagging notes  
- File attachment / image upload  

---

# 👨‍💻 12. Author

Fullstack Mini Project  
Built with Flutter + Laravel  
Student Software Engineering Project
