class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorImage;
  final String content;
  final List<String> imageUrls;
  final DateTime createdAt;
  final List<String> likes;
  final List<Comment> comments;
  final Map<String, String> tags;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorImage,
    required this.content,
    this.imageUrls = const [],
    required this.createdAt,
    this.likes = const [],
    this.comments = const [],
    this.tags = const {},
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      authorImage: map['authorImage'],
      content: map['content'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      likes: List<String>.from(map['likes'] ?? []),
      comments: (map['comments'] as List? ?? [])
          .map((c) => Comment.fromMap(c))
          .toList(),
      tags: Map<String, String>.from(map['tags'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'authorImage': authorImage,
      'content': content,
      'imageUrls': imageUrls,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
      'comments': comments.map((c) => c.toMap()).toList(),
      'tags': tags,
    };
  }
}

class Comment {
  final String id;
  final String authorId;
  final String authorName;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}