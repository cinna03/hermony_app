import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> loadUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await _userService.getUser(userId);
    } catch (e) {
      print('Error loading user: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    try {
      await _userService.createUser(user);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _userService.updateUser(user);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> updateProgress({
    int? coursesCompleted,
    int? hoursLearned,
    int? certificatesEarned,
    int? communityPosts,
  }) async {
    if (_currentUser == null) return;

    try {
      await _userService.updateUserProgress(
        userId: _currentUser!.id,
        coursesCompleted: coursesCompleted,
        hoursLearned: hoursLearned,
        certificatesEarned: certificatesEarned,
        communityPosts: communityPosts,
      );
      
      // Reload user data
      await loadUser(_currentUser!.id);
    } catch (e) {
      print('Error updating progress: $e');
    }
  }

  Future<void> addAchievement(String achievement) async {
    if (_currentUser == null) return;

    try {
      await _userService.addAchievement(_currentUser!.id, achievement);
      await loadUser(_currentUser!.id);
    } catch (e) {
      print('Error adding achievement: $e');
    }
  }

  void clearUser() {
    _currentUser = null;
    notifyListeners();
  }
}