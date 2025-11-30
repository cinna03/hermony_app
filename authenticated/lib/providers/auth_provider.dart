import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  String? _userEmail;
  String? _userId;
  bool _isLoading = false;
  String? _error;

  String? get userEmail => _userEmail;
  String? get userId => _userId;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _userEmail != null;

  AuthProvider() {
    _userEmail = _authService.currentUser?.email;
    _userId = _authService.currentUser?.uid;
    _authService.authStateChanges.listen((user) {
      _userEmail = user?.email;
      _userId = user?.uid;
      notifyListeners();
    });
  }

  Future<bool> signInWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final result = await _authService.signInWithEmail(email, password);
      if (result != null) {
        _userEmail = result.user?.email;
        _userId = result.user?.uid;
        _error = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signUpWithEmail(String email, String password, {String? name}) async {
    _setLoading(true);
    try {
      final result = await _authService.signUpWithEmail(email, password);
      if (result != null && result.user != null) {
        _userEmail = result.user!.email;
        _userId = result.user!.uid;
        
        // Create user profile
        final user = User(
          id: result.user!.uid,
          email: result.user!.email!,
          name: name ?? result.user!.displayName ?? 'User',
          createdAt: DateTime.now(),
        );
        await _userService.createUser(user);
        
        _error = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    try {
      final result = await _authService.signInWithGoogle();
      if (result != null && result.user != null) {
        _userEmail = result.user!.email;
        _userId = result.user!.uid;
        
        // Check if user profile exists, create if not
        final existingUser = await _userService.getUser(result.user!.uid);
        if (existingUser == null) {
          final user = User(
            id: result.user!.uid,
            email: result.user!.email!,
            name: result.user!.displayName ?? 'User',
            profileImage: result.user!.photoURL,
            createdAt: DateTime.now(),
          );
          await _userService.createUser(user);
        }
        
        _error = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _userEmail = null;
    _userId = null;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _authService.sendPasswordResetEmail(email);
  }

  void _updateUser() {
    _userEmail = _authService.currentUser?.email;
    _userId = _authService.currentUser?.uid;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}