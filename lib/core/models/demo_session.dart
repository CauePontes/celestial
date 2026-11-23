import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  const UserProfile({
    this.firstName,
    this.birthDate,
    this.birthTime,
    this.birthCity,
    this.preferredLocale,
  });
  final String? firstName;
  final DateTime? birthDate;
  final String? birthTime;
  final String? birthCity;
  final String? preferredLocale;
}

class DemoSession {
  const DemoSession({this.profile = const UserProfile(), this.isGuest = true});
  final UserProfile profile;
  final bool isGuest;
}

final demoSessionProvider = Provider<DemoSession>((ref) => const DemoSession());
