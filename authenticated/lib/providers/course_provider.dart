import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/course_service.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService _courseService = CourseService();
  List<Course> _courses = [];
  List<CourseProgress> _userProgress = [];
  bool _isLoading = false;

  List<Course> get courses => _courses;
  List<CourseProgress> get userProgress => _userProgress;
  bool get isLoading => _isLoading;

  void loadCourses() {
    _courseService.getCoursesStream().listen((courses) {
      _courses = courses;
      notifyListeners();
    });
  }

  void loadUserProgress(String userId) {
    _courseService.getUserProgressStream(userId).listen((progress) {
      _userProgress = progress;
      notifyListeners();
    });
  }

  Future<void> enrollInCourse(String userId, String courseId) async {
    try {
      await _courseService.enrollInCourse(userId, courseId);
    } catch (e) {
      print('Error enrolling in course: $e');
    }
  }

  Future<void> updateProgress(String userId, String courseId, String lessonId) async {
    try {
      await _courseService.updateProgress(userId, courseId, lessonId);
    } catch (e) {
      print('Error updating progress: $e');
    }
  }

  CourseProgress? getCourseProgress(String courseId) {
    try {
      return _userProgress.firstWhere((p) => p.courseId == courseId);
    } catch (e) {
      return null;
    }
  }

  bool isEnrolled(String courseId) {
    return _userProgress.any((p) => p.courseId == courseId);
  }

  List<Course> get enrolledCourses {
    final enrolledIds = _userProgress.map((p) => p.courseId).toSet();
    return _courses.where((c) => enrolledIds.contains(c.id)).toList();
  }

  List<Course> get completedCourses {
    final completedIds = _userProgress
        .where((p) => p.progressPercentage >= 100)
        .map((p) => p.courseId)
        .toSet();
    return _courses.where((c) => completedIds.contains(c.id)).toList();
  }
}