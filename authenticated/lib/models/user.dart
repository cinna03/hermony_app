class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final String? bio;
  final List<String> interests;
  final String experienceLevel;
  final List<String> goals;
  final int coursesCompleted;
  final int hoursLearned;
  final int certificatesEarned;
  final int communityPosts;
  final List<String> achievements;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.bio,
    this.interests = const [],
    this.experienceLevel = 'Beginner',
    this.goals = const [],
    this.coursesCompleted = 0,
    this.hoursLearned = 0,
    this.certificatesEarned = 0,
    this.communityPosts = 0,
    this.achievements = const [],
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profileImage: map['profileImage'],
      bio: map['bio'],
      interests: List<String>.from(map['interests'] ?? []),
      experienceLevel: map['experienceLevel'] ?? 'Beginner',
      goals: List<String>.from(map['goals'] ?? []),
      coursesCompleted: map['coursesCompleted'] ?? 0,
      hoursLearned: map['hoursLearned'] ?? 0,
      certificatesEarned: map['certificatesEarned'] ?? 0,
      communityPosts: map['communityPosts'] ?? 0,
      achievements: List<String>.from(map['achievements'] ?? []),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'bio': bio,
      'interests': interests,
      'experienceLevel': experienceLevel,
      'goals': goals,
      'coursesCompleted': coursesCompleted,
      'hoursLearned': hoursLearned,
      'certificatesEarned': certificatesEarned,
      'communityPosts': communityPosts,
      'achievements': achievements,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }
}