import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import '../../core/utils/context_extensions.dart';
import '../../features/onboarding/entry_screens.dart';
import '../../features/onboarding/birth_details_screen.dart';
import '../../features/onboarding/interests_screen.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/discover_screen.dart';
import '../../features/astrology/astrology_hub_screen.dart';
import '../../features/astrology/horoscope_screen.dart';
import '../../features/astrology/birth_chart_screen.dart';
import '../../features/astrology/insight_screen.dart';
import '../../features/astrology/zodiac_signs_screen.dart';
import '../../features/numerology/numerology_screens.dart';
import '../../features/love/love_hub_screen.dart';
import '../../features/love/compatibility_report_screen.dart';
import '../../features/wellness/wellness_hub_screen.dart';
import '../../features/wellness/meditation_screens.dart';
import '../../features/wellness/breathing_exercise_screen.dart';
import '../../features/journal/journal_screen.dart';
import '../../features/journal/journal_editor_screen.dart';
import '../../features/community/community_feed_screen.dart';
import '../../features/community/community_post_screen.dart';
import '../../features/community/create_post_screen.dart';
import '../../features/engagement/cosmic_calendar_screen.dart';
import '../../features/engagement/notifications_screen.dart';
import '../../features/engagement/achievements_screen.dart';
import '../../features/premium/premium_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/settings_screens.dart';
import '../../features/profile/favorites_screen.dart';

final initialLocationProvider = Provider<String>((ref) => '/splash');

/// Canonical concrete routes used for coverage audits, deep links and tests.
const prototypeRouteSamples = [
  '/splash',
  '/welcome',
  '/intro',
  '/sign-in',
  '/sign-up',
  '/recover',
  '/birth-details',
  '/interests',
  '/home',
  '/astrology',
  '/love',
  '/wellness',
  '/profile',
  '/discover',
  '/calendar',
  '/notifications',
  '/horoscope',
  '/zodiac',
  '/birth-chart',
  '/chart-details',
  '/insight',
  '/planet/0',
  '/numerology',
  '/life-path',
  '/numerology-report',
  '/partner-details',
  '/compatibility-result',
  '/compatibility-report',
  '/relationship-insight',
  '/meditations',
  '/meditation/moonrise',
  '/meditation-player/moonrise',
  '/breathing',
  '/journal',
  '/journal/new',
  '/journal/sample/edit',
  '/community',
  '/community/post/sample-0',
  '/community/new',
  '/community/report/sample-0',
  '/premium',
  '/credits',
  '/edit-profile',
  '/settings',
  '/language',
  '/privacy',
  '/achievements',
  '/favorites',
];

final routerProvider = Provider<GoRouter>((ref) {
  GoRoute page(
    String path,
    Widget Function(BuildContext, GoRouterState) build,
  ) => GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      transitionDuration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 240),
      child: build(context, state),
      transitionsBuilder: (context, animation, secondary, child) =>
          FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(.025, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
              child: child,
            ),
          ),
    ),
  );
  final router = GoRouter(
    initialLocation: ref.read(initialLocationProvider),
    errorBuilder: (context, state) => PageFrame(
      title: context.l.noResults,
      back: false,
      children: [
        EmptyState(title: context.l.noResults, body: context.l.noEntriesBody),
        const SizedBox(height: 24),
        PrimaryButton(
          label: context.l.backHome,
          onPressed: () => context.go('/home'),
        ),
      ],
    ),
    routes: [
      page('/splash', (c, s) => const SplashScreen()),
      page('/welcome', (c, s) => const WelcomeScreen()),
      page('/intro', (c, s) => const IntroScreen()),
      page('/sign-in', (c, s) => const AuthScreen(mode: AuthMode.signIn)),
      page('/sign-up', (c, s) => const AuthScreen(mode: AuthMode.signUp)),
      page('/recover', (c, s) => const AuthScreen(mode: AuthMode.recover)),
      page('/birth-details', (c, s) => const BirthDetailsScreen()),
      page(
        '/interests',
        (c, s) =>
            InterestsScreen(edit: s.uri.queryParameters['edit'] == 'true'),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => PopScope(
          canPop: shell.currentIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && shell.currentIndex != 0) shell.goBranch(0);
          },
          child: Scaffold(
            body: shell,
            bottomNavigationBar: AppBottomNav(shell: shell),
          ),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (c, s) => const HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/astrology',
                builder: (c, s) => const AstrologyHubScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/love', builder: (c, s) => const LoveHubScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/wellness',
                builder: (c, s) => const WellnessHubScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (c, s) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      page('/discover', (c, s) => const DiscoverScreen()),
      page('/calendar', (c, s) => CosmicCalendarScreen(initialMonth:DateTime.tryParse(s.uri.queryParameters['month']??''))),
      page('/notifications', (c, s) => const NotificationsScreen()),
      page(
        '/horoscope',
        (c, s) => HoroscopeScreen(
          initialSign: int.tryParse(s.uri.queryParameters['sign'] ?? '6') ?? 6,
          initialPeriod: int.tryParse(s.uri.queryParameters['period']??'0')??0,
          initialDate:DateTime.tryParse(s.uri.queryParameters['date']??''),
        ),
      ),
      page('/zodiac', (c, s) => const ZodiacSignsScreen()),
      page('/birth-chart', (c, s) => const BirthChartScreen()),
      page('/chart-details', (c, s) => const ChartDetailsScreen()),
      page(
        '/insight',
        (c, s) => AstrologicalInsightScreen(
          kind: s.uri.queryParameters['kind'] ?? 'general',
          index: int.tryParse(s.uri.queryParameters['index'] ?? '0') ?? 0,
        ),
      ),
      page(
        '/planet/:index',
        (c, s) => PlanetDetailScreen(
          index: int.tryParse(s.pathParameters['index'] ?? '0') ?? 0,
        ),
      ),
      page('/numerology', (c, s) => const NumerologyHubScreen()),
      page('/life-path', (c, s) => const LifePathScreen()),
      page('/numerology-report', (c, s) => const NumerologyReportScreen()),
      page(
        '/partner-details',
        (c, s) => const BirthDetailsScreen(partner: true),
      ),
      page(
        '/compatibility-result',
        (c, s) => const CompatibilityResultScreen(),
      ),
      page(
        '/compatibility-report',
        (c, s) => const CompatibilityReportScreen(),
      ),
      page(
        '/relationship-insight',
        (c, s) => RelationshipInsightScreen(
          article: int.tryParse(s.uri.queryParameters['article'] ?? '0') ?? 0,
        ),
      ),
      page('/meditations', (c, s) => const MeditationLibraryScreen()),
      page(
        '/meditation/:id',
        (c, s) => MeditationDetailsScreen(id: s.pathParameters['id']!),
      ),
      page(
        '/meditation-player/:id',
        (c, s) => MeditationPlayerScreen(id: s.pathParameters['id']!),
      ),
      page(
        '/breathing',
        (c, s) => BreathingExerciseScreen(
          pattern: s.uri.queryParameters['pattern'] ?? 'calm',
        ),
      ),
      page('/journal', (c, s) => const JournalScreen()),
      page('/journal/new', (c, s) => const JournalEditorScreen()),
      page(
        '/journal/:id/edit',
        (c, s) => JournalEditorScreen(id: s.pathParameters['id']),
      ),
      page('/community', (c, s) => const CommunityFeedScreen()),
      page('/community/new', (c, s) => const CreatePostScreen()),
      page(
        '/community/post/:id',
        (c, s) => CommunityPostScreen(id: s.pathParameters['id']!),
      ),
      page(
        '/community/report/:id',
        (c, s) => ReportPostScreen(id: s.pathParameters['id']!),
      ),
      page('/premium', (c, s) => const PremiumScreen()),
      page('/credits', (c, s) => const CreditsScreen()),
      page('/edit-profile', (c, s) => const BirthDetailsScreen(edit: true)),
      page('/settings', (c, s) => const SettingsScreen()),
      page('/language', (c, s) => const LanguageSettingsScreen()),
      page('/privacy', (c, s) => const PrivacyHelpScreen()),
      page('/achievements', (c, s) => const AchievementsScreen()),
      page(
        '/favorites',
        (c, s) => FavoritesScreen(type: s.uri.queryParameters['type']),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
