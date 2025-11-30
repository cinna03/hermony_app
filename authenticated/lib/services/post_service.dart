import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    await _firestore.collection('posts').add(post.toMap());
  }

  Stream<List<Post>> getPostsStream() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> likePost(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> unlikePost(String postId, String userId) async {
    await _firestore.collection('posts').doc(postId).update({
      'likes': FieldValue.arrayRemove([userId])
    });
  }

  Future<void> addComment(String postId, Comment comment) async {
    await _firestore.collection('posts').doc(postId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()])
    });
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  Stream<List<Post>> getUserPostsStream(String userId) {
    return _firestore
        .collection('posts')
        .where('authorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post.fromMap(doc.data(), doc.id))
            .toList());
  }
}