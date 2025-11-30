import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';

class EventProvider extends ChangeNotifier {
  final EventService _eventService = EventService();
  List<Event> _events = [];
  List<Event> _userEvents = [];
  bool _isLoading = false;

  List<Event> get events => _events;
  List<Event> get userEvents => _userEvents;
  List<Event> get upcomingEvents => _events.where((e) => e.isUpcoming).take(5).toList();
  bool get isLoading => _isLoading;

  void loadEvents() {
    _eventService.getEventsStream().listen((events) {
      _events = events;
      notifyListeners();
    });
  }

  void loadUserEvents(String userId) {
    _eventService.getUserEventsStream(userId).listen((events) {
      _userEvents = events;
      notifyListeners();
    });
  }

  Future<void> rsvpToEvent(String eventId, String userId) async {
    try {
      await _eventService.rsvpToEvent(eventId, userId);
    } catch (e) {
      print('Error RSVPing to event: $e');
    }
  }

  Future<void> cancelRsvp(String eventId, String userId) async {
    try {
      await _eventService.cancelRsvp(eventId, userId);
    } catch (e) {
      print('Error canceling RSVP: $e');
    }
  }

  bool isRsvped(String eventId, String userId) {
    final event = _events.firstWhere((e) => e.id == eventId, orElse: () => Event(
      id: '',
      title: '',
      description: '',
      dateTime: DateTime.now(),
      type: '',
      host: '',
      location: '',
      imageUrl: '',
      maxAttendees: 0,
      createdAt: DateTime.now(),
    ));
    return event.attendeeIds.contains(userId);
  }

  List<Event> getEventsByType(String type) {
    return _events.where((e) => e.type.toLowerCase() == type.toLowerCase()).toList();
  }
}