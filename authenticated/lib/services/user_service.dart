import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<User?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return User.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<void> updateUserProgress({
    required String userId,
    int? coursesCompleted,
    int? hoursLearned,
    int? certificatesEarned,
    int? communityPosts,
  }) async {
    Map<String, dynamic> updates = {};
    
    if (coursesCompleted != null) {
      updates['coursesCompleted'] = FieldValue.increment(coursesCompleted);
    }
    if (hoursLearned != null) {
      updates['hoursLearned'] = FieldValue.increment(hoursLearned);
    }
    if (certificatesEarned != null) {
      updates['certificatesEarned'] = FieldValue.increment(certificatesEarned);
    }
    if (communityPosts != null) {
      updates['communityPosts'] = FieldValue.increment(communityPosts);
    }

    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(userId).update(updates);
    }
  }

  Future<void> addAchievement(String userId, String achievement) async {
    await _firestore.collection('users').doc(userId).update({
      'achievements': FieldValue.arrayUnion([achievement])
    });
  }

  Stream<User?> getUserStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? User.fromMap(doc.data()!, doc.id) : null);
  }
}