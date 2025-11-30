import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Event>> getEventsStream() {
    return _firestore
        .collection('events')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Event.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<List<Event>> getUpcomingEventsStream() {
    return _firestore
        .collection('events')
        .where('dateTime', isGreaterThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy('dateTime', descending: false)
        .limit(10)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Event.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<Event?> getEvent(String eventId) async {
    final doc = await _firestore.collection('events').doc(eventId).get();
    if (doc.exists) {
      return Event.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> rsvpToEvent(String eventId, String userId) async {
    await _firestore.collection('events').doc(eventId).update({
      'attendeeIds': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> cancelRsvp(String eventId, String userId) async {
    await _firestore.collection('events').doc(eventId).update({
      'attendeeIds': FieldValue.arrayRemove([userId])
    });
  }

  Stream<List<Event>> getUserEventsStream(String userId) {
    return _firestore
        .collection('events')
        .where('attendeeIds', arrayContains: userId)
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Event.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> createEvent(Event event) async {
    await _firestore.collection('events').add(event.toMap());
  }
}