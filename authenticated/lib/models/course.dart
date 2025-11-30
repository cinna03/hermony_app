class Course {
  final String id;
  final String title;
  final String description;
  final String category;
  final String instructor;
  final String imageUrl;
  final double rating;
  final int students;
  final String level;
  final int duration;
  final List<String> tags;
  final bool isFree;
  final double? price;
  final List<Lesson> lessons;
  final DateTime createdAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.imageUrl,
    required this.rating,
    required this.students,
    required this.level,
    required this.duration,
    this.tags = const [],
    this.isFree = true,
    this.price,
    this.lessons = const [],
    required this.createdAt,
  });

  factory Course.fromMap(Map<String, dynamic> map, String id) {
    return Course(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      instructor: map['instructor'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      students: map['students'] ?? 0,
      level: map['level'] ?? '',
      duration: map['duration'] ?? 0,
      tags: List<String>.from(map['tags'] ?? []),
      isFree: map['isFree'] ?? true,
      price: map['price']?.toDouble(),
      lessons: (map['lessons'] as List? ?? [])
          .map((l) => Lesson.fromMap(l))
          .toList(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'instructor': instructor,
      'imageUrl': imageUrl,
      'rating': rating,
      'students': students,
      'level': level,
      'duration': duration,
      'tags': tags,
      'isFree': isFree,
      'price': price,
      'lessons': lessons.map((l) => l.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}

class Lesson {
  final String id;
  final String title;
  final String content;
  final String? videoUrl;
  final int duration;
  final int order;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    this.videoUrl,
    required this.duration,
    required this.order,
  });

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      videoUrl: map['videoUrl'],
      duration: map['duration'] ?? 0,
      order: map['order'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'videoUrl': videoUrl,
      'duration': duration,
      'order': order,
    };
  }
}

class CourseProgress {
  final String userId;
  final String courseId;
  final List<String> completedLessons;
  final double progressPercentage;
  final DateTime lastAccessed;
  final DateTime? completedAt;

  CourseProgress({
    required this.userId,
    required this.courseId,
    this.completedLessons = const [],
    this.progressPercentage = 0.0,
    required this.lastAccessed,
    this.completedAt,
  });

  factory CourseProgress.fromMap(Map<String, dynamic> map) {
    return CourseProgress(
      userId: map['userId'] ?? '',
      courseId: map['courseId'] ?? '',
      completedLessons: List<String>.from(map['completedLessons'] ?? []),
      progressPercentage: (map['progressPercentage'] ?? 0).toDouble(),
      lastAccessed: DateTime.fromMillisecondsSinceEpoch(map['lastAccessed'] ?? 0),
      completedAt: map['completedAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['completedAt'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'courseId': courseId,
      'completedLessons': completedLessons,
      'progressPercentage': progressPercentage,
      'lastAccessed': lastAccessed.millisecondsSinceEpoch,
      'completedAt': completedAt?.millisecondsSinceEpoch,
    };
  }
}