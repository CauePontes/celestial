import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/prototype_models.dart';

@immutable
class PrototypeState {
  const PrototypeState({
    this.profile = const UserProfile(),
    this.partner = const UserProfile(),
    this.interests = const {0, 3},
    this.mood = 0,
    this.journal = const [],
    this.posts = const [],
    this.saved = const {},
    this.likes = const {},
    this.blocked = const {},
    this.readNotifications = const {},
    this.comments = const {},
    this.reminders = true,
    this.houseSystem = 0,
    this.breathingCycles = 0,
    this.readingCount = 0,
  });
  final UserProfile profile, partner;
  final Set<int> interests, readNotifications;
  final int mood, houseSystem, breathingCycles, readingCount;
  final List<JournalEntry> journal;
  final List<CommunityPost> posts;
  final Set<String> saved, likes, blocked;
  final Map<String, List<DemoComment>> comments;
  final bool reminders;

  PrototypeState copyWith({
    UserProfile? profile,
    UserProfile? partner,
    Set<int>? interests,
    int? mood,
    List<JournalEntry>? journal,
    List<CommunityPost>? posts,
    Set<String>? saved,
    Set<String>? likes,
    Set<String>? blocked,
    Set<int>? readNotifications,
    Map<String, List<DemoComment>>? comments,
    bool? reminders,
    int? houseSystem,
    int? breathingCycles,
    int? readingCount,
  }) => PrototypeState(
    profile: profile ?? this.profile,
    partner: partner ?? this.partner,
    interests: Set.unmodifiable(interests ?? this.interests),
    mood: mood ?? this.mood,
    journal: List.unmodifiable(journal ?? this.journal),
    posts: List.unmodifiable(posts ?? this.posts),
    saved: Set.unmodifiable(saved ?? this.saved),
    likes: Set.unmodifiable(likes ?? this.likes),
    blocked: Set.unmodifiable(blocked ?? this.blocked),
    readNotifications: Set.unmodifiable(
      readNotifications ?? this.readNotifications,
    ),
    comments: Map.unmodifiable(comments ?? this.comments),
    reminders: reminders ?? this.reminders,
    houseSystem: houseSystem ?? this.houseSystem,
    breathingCycles: breathingCycles ?? this.breathingCycles,
    readingCount: readingCount ?? this.readingCount,
  );
}

final prototypeProvider = NotifierProvider<PrototypeController, PrototypeState>(
  PrototypeController.new,
);

class PrototypeController extends Notifier<PrototypeState> {
  int _sequence = 0;
  @override
  PrototypeState build() => const PrototypeState();
  String nextId() => '${DateTime.now().microsecondsSinceEpoch}-${_sequence++}';
  void setProfile(UserProfile profile) =>
      state = state.copyWith(profile: profile);
  void setPartner(UserProfile profile) =>
      state = state.copyWith(partner: profile);
  void setMood(int mood) => state = state.copyWith(mood: mood);
  void toggleInterest(int index) {
    final selected = {...state.interests};
    selected.contains(index) ? selected.remove(index) : selected.add(index);
    state = state.copyWith(interests: selected);
  }

  void toggleSaved(String id) {
    final selected = {...state.saved};
    selected.contains(id) ? selected.remove(id) : selected.add(id);
    state = state.copyWith(saved: selected);
  }

  void toggleLike(String id) {
    final selected = {...state.likes};
    selected.contains(id) ? selected.remove(id) : selected.add(id);
    state = state.copyWith(likes: selected);
  }

  void saveJournal(JournalEntry entry) => state = state.copyWith(
    journal: [entry, ...state.journal.where((e) => e.id != entry.id)],
  );
  void deleteJournal(String id) => state = state.copyWith(
    journal: state.journal.where((e) => e.id != id).toList(),
  );
  void addPost(CommunityPost post) =>
      state = state.copyWith(posts: [post, ...state.posts]);
  void addComment(String post, DemoComment comment) => state = state.copyWith(
    comments: {
      ...state.comments,
      post: List.unmodifiable([...state.comments[post] ?? [], comment]),
    },
  );
  void block(String author) =>
      state = state.copyWith(blocked: {...state.blocked, author});
  void markRead(int id) => state = state.copyWith(
    readNotifications: {...state.readNotifications, id},
  );
  void markAllRead() => state = state.copyWith(readNotifications: {0, 1, 2});
  void setReminders(bool enabled) => state = state.copyWith(reminders: enabled);
  void setHouseSystem(int value) => state = state.copyWith(houseSystem: value);
  void addBreathingCycle() =>
      state = state.copyWith(breathingCycles: state.breathingCycles + 1);
  void recordReading() =>
      state = state.copyWith(readingCount: state.readingCount + 1);
  void reset() => state = const PrototypeState();
}
