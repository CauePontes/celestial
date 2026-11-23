import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../demo/prototype_controller.dart';
import 'prototype_models.dart';
export 'prototype_models.dart' show UserProfile;

/// An explicitly local guest session; no authenticated account is implied.
class DemoSession {
  const DemoSession({this.profile = const UserProfile(), this.isGuest = true});
  final UserProfile profile;
  final bool isGuest;
}

final demoSessionProvider = Provider<DemoSession>(
  (ref) => DemoSession(
    profile: ref.watch(prototypeProvider.select((s) => s.profile)),
  ),
);
