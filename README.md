# Celestial · Day 1

Original Flutter frontend for iOS and Android, with a web target for local review.
Only the foundation stage is implemented. No backend, account service, payments,
remote content, or AI integrations exist.

## Run

```sh
flutter pub get
flutter run -d chrome --web-port 5180
```

Use `flutter run` with an attached Android/iOS device for mobile. Building iOS
requires macOS and Xcode. This Windows environment cannot verify the iOS build.

## Included in Day 1

- Exact dark celestial palette, editorial system serif headings, system body
  typography, original orbit illustrations drawn with CustomPainter.
- Demonstration Home, preview skeletons for Astrology, Love and Wellness,
  and a Profile foundation with a working language selector.
- Exactly five tabs using GoRouter StatefulShellRoute.indexedStack; branch
  navigation and scroll positions are retained.
- Reusable scaffold, cosmic background, surface and insight cards, hero card,
  feature tiles, section headers, primary/secondary buttons, text field, empty
  state, static skeleton, preview badges, demo notice and bottom navigation.
- Flutter generated ARB localization with en_US/es_US, preferred device language
  list resolution, English fallback, localized dates, and persisted override.
- Riverpod-injected InterpretationRepository / MockInterpretationRepository,
  immutable interpretation, UserProfile and DemoSession models.

The Profile language selector is included now because it is a Day 1 acceptance
criterion; onboarding, account forms and full feature flows remain later work.
Preview tiles open honest explanatory sheets or navigate to their relevant tab.
Skeleton lines describe unfinished sections and do not imply an active request.

## Architecture and decisions

`lib/app` contains theme, router and preference state. `lib/core` contains shared
widgets and immutable demonstration models. `lib/features` contains presentation
screens. `lib/l10n` contains both base language files (required by gen_l10n) and
US regional variants. Keep corresponding translations aligned when editing.

All visible copy and illustrative interpretation text are localized in ARB.
InterpretationRepository returns typed immutable values and is replaceable via
Riverpod. It performs no calculation or network access. The sample Virgo badge
is explicitly labeled as a sample and does not represent the visitor's sign.

Only the manual language preference is stored in SharedPreferences. Choosing
device language removes the override. Birth information is not collected yet;
DemoSession is an in-memory guest model. No journal storage is implemented.

System font fallbacks avoid runtime font downloads and unlicensed bundled assets.
The artwork is original code, has no external image dependency, and is decorative.
No custom animation is enabled in this stage; Material handles reduced motion.

## Verification

```sh
dart format .
flutter analyze
flutter test
flutter build apk --debug
```

Five tests cover preferred language ordering/fallback, persisted override and
reset, five-tab navigation and retained scroll, preview-sheet dismissal,
device Spanish/manual English switching, and Spanish layouts at 375 × 812
with 200% text scaling. Final execution results and environment limits are in
`docs/day-1-report.md`.

Do not start Day 2 until explicitly requested.
