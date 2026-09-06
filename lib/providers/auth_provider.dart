import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  User? get currentUser =>
      _authService.currentUser;

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    try {
      await _authService.register(
        email: email,
        password: password,
      );

      _errorMessage = null;

      return true;
    } on FirebaseAuthException catch (error) {
      _errorMessage = error.message;

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    try {
      await _authService.login(
        email: email,
        password: password,
      );

      _errorMessage = null;

      return true;
    } on FirebaseAuthException catch (error) {
      _errorMessage = error.message;

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}