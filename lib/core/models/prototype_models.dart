import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  const UserProfile({
    this.name = '',
    this.birthDate,
    this.birthMinutes,
    this.city = '',
    this.unknownTime = false,
  });
  final String name;
  final DateTime? birthDate;
  final int? birthMinutes;
  final String city;
  final bool unknownTime;
}

@immutable
class ZodiacSign {
  const ZodiacSign(
    this.id,
    this.name,
    this.glyph,
    this.element,
    this.mode,
    this.start,
    this.end,
  );
  final int id;
  final String name, glyph, element, mode;
  final DateTime start, end;
}

@immutable
class Meditation {
  const Meditation(
    this.id,
    this.title,
    this.category,
    this.minutes,
    this.description,
    this.asset,
  );
  final String id, title, category, description, asset;
  final int minutes;
}

enum EventCategory { moon, transit, personal }

@immutable
class CosmicEvent {
  const CosmicEvent(
    this.id,
    this.title,
    this.body,
    this.badge,
    this.date,
    this.category,
  );
  final String id, title, body, badge;
  final DateTime date;
  final EventCategory category;
}

@immutable
class JournalEntry {
  const JournalEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.mood,
    required this.date,
  });
  final String id, title, body;
  final int mood;
  final DateTime date;
}

@immutable
class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.author,
    required this.body,
    this.category = 0,
    this.title = '',
    this.isLocal = false,
  });
  final String id, author, body, title;
  final int category;
  final bool isLocal;
}

@immutable
class DemoComment {
  const DemoComment(this.author, this.body);
  final String author, body;
}

@immutable
class PrototypeCatalog {
  PrototypeCatalog({
    required List<ZodiacSign> signs,
    required List<Meditation> meditations,
    required List<CommunityPost> posts,
  }) : signs = List.unmodifiable(signs),
       meditations = List.unmodifiable(meditations),
       posts = List.unmodifiable(posts);
  final List<ZodiacSign> signs;
  final List<Meditation> meditations;
  final List<CommunityPost> posts;
}
