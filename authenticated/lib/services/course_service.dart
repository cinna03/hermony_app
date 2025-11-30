import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/course.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Course>> getCoursesStream() {
    return _firestore
        .collection('courses')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Course.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<Course?> getCourse(String courseId) async {
    final doc = await _firestore.collection('courses').doc(courseId).get();
    if (doc.exists) {
      return Course.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> enrollInCourse(String userId, String courseId) async {
    final progress = CourseProgress(
      userId: userId,
      courseId: courseId,
      lastAccessed: DateTime.now(),
    );

    await _firestore
        .collection('courseProgress')
        .doc('${userId}_$courseId')
        .set(progress.toMap());

    // Increment enrolled students count
    await _firestore.collection('courses').doc(courseId).update({
      'students': FieldValue.increment(1)
    });
  }

  Future<void> updateProgress(String userId, String courseId, String lessonId) async {
    final progressDoc = _firestore
        .collection('courseProgress')
        .doc('${userId}_$courseId');

    await progressDoc.update({
      'completedLessons': FieldValue.arrayUnion([lessonId]),
      'lastAccessed': DateTime.now().millisecondsSinceEpoch,
    });

    // Calculate progress percentage
    final course = await getCourse(courseId);
    if (course != null) {
      final doc = await progressDoc.get();
      if (doc.exists) {
        final progress = CourseProgress.fromMap(doc.data()!);
        final percentage = (progress.completedLessons.length / course.lessons.length) * 100;
        
        await progressDoc.update({
          'progressPercentage': percentage,
          'completedAt': percentage >= 100 ? DateTime.now().millisecondsSinceEpoch : null,
        });
      }
    }
  }

  Stream<CourseProgress?> getCourseProgressStream(String userId, String courseId) {
    return _firestore
        .collection('courseProgress')
        .doc('${userId}_$courseId')
        .snapshots()
        .map((doc) => doc.exists ? CourseProgress.fromMap(doc.data()!) : null);
  }

  Stream<List<CourseProgress>> getUserProgressStream(String userId) {
    return _firestore
        .collection('courseProgress')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CourseProgress.fromMap(doc.data()))
            .toList());
  }
}