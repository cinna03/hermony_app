class Event {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String type;
  final String host;
  final String location;
  final String imageUrl;
  final int maxAttendees;
  final List<String> attendeeIds;
  final bool isVirtual;
  final String? meetingLink;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.type,
    required this.host,
    required this.location,
    required this.imageUrl,
    required this.maxAttendees,
    this.attendeeIds = const [],
    this.isVirtual = false,
    this.meetingLink,
    required this.createdAt,
  });

  factory Event.fromMap(Map<String, dynamic> map, String id) {
    return Event(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] ?? 0),
      type: map['type'] ?? '',
      host: map['host'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      maxAttendees: map['maxAttendees'] ?? 0,
      attendeeIds: List<String>.from(map['attendeeIds'] ?? []),
      isVirtual: map['isVirtual'] ?? false,
      meetingLink: map['meetingLink'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'type': type,
      'host': host,
      'location': location,
      'imageUrl': imageUrl,
      'maxAttendees': maxAttendees,
      'attendeeIds': attendeeIds,
      'isVirtual': isVirtual,
      'meetingLink': meetingLink,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  bool get isFull => attendeeIds.length >= maxAttendees;
  bool get isUpcoming => dateTime.isAfter(DateTime.now());
  int get attendeeCount => attendeeIds.length;
}