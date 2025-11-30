import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class ForumProvider extends ChangeNotifier {
  final PostService _postService = PostService();
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  ForumProvider() {
    loadPosts();
  }

  void loadPosts() {
    _postService.getPostsStream().listen((posts) {
      _posts = posts;
      notifyListeners();
    });
  }

  Future<void> createPost({
    required String content,
    required String authorId,
    required String authorName,
    String? authorImage,
    List<String> imageUrls = const [],
  }) async {
    try {
      final post = Post(
        id: '',
        authorId: authorId,
        authorName: authorName,
        authorImage: authorImage,
        content: content,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
      );
      await _postService.createPost(post);
    } catch (e) {
      print('Error creating post: $e');
    }
  }

  Future<void> likePost(String postId, String userId) async {
    try {
      final post = _posts.firstWhere((p) => p.id == postId);
      if (post.likes.contains(userId)) {
        await _postService.unlikePost(postId, userId);
      } else {
        await _postService.likePost(postId, userId);
      }
    } catch (e) {
      print('Error liking post: $e');
    }
  }

  Future<void> addComment(String postId, String content, String authorId, String authorName) async {
    try {
      final comment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authorId: authorId,
        authorName: authorName,
        content: content,
        createdAt: DateTime.now(),
      );
      await _postService.addComment(postId, comment);
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _postService.deletePost(postId);
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}