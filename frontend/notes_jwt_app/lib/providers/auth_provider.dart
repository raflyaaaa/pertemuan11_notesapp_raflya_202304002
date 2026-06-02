import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  final _storageService = StorageService();
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  // Cek Session saat aplikasi pertama kali dibuka
  Future<void> checkSession() async {
    _token = await _storageService.getToken();
    notifyListeners();
  }
  // Fungsi Login
  Future<bool> login(String email, String password) async {

    await _storageService.deleteToken();

    _isLoading = true;
    notifyListeners();

    // Ganti URL dengan URL API Backend Anda
    final url = Uri.parse('https://coercible-ranee-militantly.ngrok-free.dev/api/login');
    try {
      print(email);
      print(password);
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'x-api-key': 'free_user_3EZ0stfhQsx5oifpwkPQ3fAZvuW',
        },

        body: jsonEncode({'email': email, 'password': password}),
      );

      print(response.statusCode);
      print(response.body);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token']; // Mengambil string JWT dari key 'token'
        await _storageService.saveToken(_token!);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Error Login: $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // Fungsi Logout
  Future<void> logout() async {
    _token = null;
    await _storageService.deleteToken();
    notifyListeners();
  }
}