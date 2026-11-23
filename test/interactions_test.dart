import 'package:celestial/app/router/app_router.dart';
import 'package:celestial/core/demo/prototype_controller.dart';
import 'package:celestial/core/models/prototype_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_app.dart';

void main() {
  testWidgets(
    'first use validates birth form and completes interests into Home',
    (tester) async {
      final container = await launchPrototype(tester, route: '/splash');
      await tester.pump(const Duration(seconds: 1));
      await settlePrototype(tester);
      expect(find.text('Explore your inner universe'), findsOneWidget);
      await tapVisible(tester, find.text('Get started'));
      container.read(routerProvider).push('/sign-in');
      await settlePrototype(tester);
      await tapVisible(tester, find.text('Explore as a guest'));
      await tester.enterText(find.byKey(const Key('profile-name')), '');
      await tapVisible(tester, find.text('Continue'));
      expect(find.text('Please complete this field.'), findsWidgets);
      await tester.enterText(
        find.byKey(const Key('profile-name')),
        'Nova Vega',
      );
      await tapVisible(tester, find.text('Continue'));
      expect(find.text('What draws you inward?'), findsOneWidget);
      await tapVisible(tester, find.text('Enter Celestial'));
      expect(
        container.read(routerProvider).routeInformationProvider.value.uri.path,
        '/home',
      );
      expect(container.read(prototypeProvider).profile.name, 'Nova Vega');
    },
  );
  testWidgets('journal creates edits and removes a local reflection', (
    tester,
  ) async {
    final container = await launchPrototype(tester, route: '/journal');
    await tapVisible(tester, find.text('New reflection'));
    await tapVisible(tester, find.text('Save'));
    expect(find.text('Please complete this field.'), findsWidgets);
    await tester.enterText(
      find.byKey(const Key('journal-title')),
      'A quiet morning',
    );
    await tester.enterText(
      find.byKey(const Key('journal-body')),
      'I took time to breathe.',
    );
    await tapVisible(tester, find.text('Save'));
    expect(
      container.read(prototypeProvider).journal.single.title,
      'A quiet morning',
    );
    await tapVisible(tester, find.text('A quiet morning'));
    await tester.enterText(
      find.byKey(const Key('journal-title')),
      'A gentler morning',
    );
    await tapVisible(tester, find.text('Save'));
    expect(
      container.read(prototypeProvider).journal.single.title,
      'A gentler morning',
    );
    await tapVisible(tester, find.text('A gentler morning'));
    await tapVisible(tester, find.text('Delete'));
    await tester.tap(
      find
          .descendant(
            of: find.byType(AlertDialog),
            matching: find.text('Delete'),
          )
          .last,
    );
    await settlePrototype(tester);
    expect(container.read(prototypeProvider).journal, isEmpty);
  });
  testWidgets(
    'community publishes locally, adds comment, likes, reports and blocks',
    (tester) async {
      final container = await launchPrototype(tester, route: '/community/new');
      await tester.enterText(
        find.byKey(const Key('post-title')),
        'A little gratitude',
      );
      await tester.enterText(
        find.byKey(const Key('post-body')),
        'A quiet walk made room for reflection.',
      );
      await tapVisible(tester, find.text('Publish in demo'));
      final post = container.read(prototypeProvider).posts.single;
      expect(post.isLocal, isTrue);
      container.read(routerProvider).go('/community/post/${post.id}');
      await settlePrototype(tester);
      await tapVisible(tester, find.text('Like'));
      expect(container.read(prototypeProvider).likes, contains(post.id));
      await tester.enterText(
        find.byKey(const Key('comment-body')),
        'A thoughtful reminder.',
      );
      await tapVisible(tester, find.text('Add in demo'));
      expect(
        container.read(prototypeProvider).comments[post.id]!.single.body,
        'A thoughtful reminder.',
      );
      await tapVisible(tester, find.text('Report'));
      await tapVisible(tester, find.text('Spam'));
      await tapVisible(tester, find.text('Report').last);
      expect(find.textContaining('Nothing was sent.'), findsOneWidget);
      container.read(routerProvider).go('/community/post/${post.id}');
      await settlePrototype(tester);
      await tapVisible(tester, find.text('Block this author in demo'));
      expect(container.read(prototypeProvider).blocked, contains(post.author));
    },
  );
  testWidgets('horoscope period changes content and saves a local reading', (
    tester,
  ) async {
    final container = await launchPrototype(tester, route: '/horoscope');
    expect(find.text('Quiet clarity in your conversations'), findsOneWidget);
    await tapVisible(tester, find.text('Weekly'));
    expect(find.text('Harmonies built on patient timing'), findsOneWidget);
    await tapVisible(tester, find.text('Monthly'));
    expect(find.text('Stepping into your quiet radiance'), findsOneWidget);
    await tester.tap(find.byTooltip('Save').first);
    await settlePrototype(tester);
    expect(container.read(prototypeProvider).saved.length, 1);
  });
  testWidgets('breathing progresses, pauses, resumes, counts and resets', (
    tester,
  ) async {
    final container = await launchPrototype(tester, route: '/breathing');
    await tester.tap(find.text('Start'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 5));
    expect(find.byKey(const Key('breathing-phase')), findsOneWidget);
    expect(find.text('Hold'), findsOneWidget);
    await tester.tap(find.text('Pause'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 8));
    expect(find.text('Hold'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 15));
    await tester.pump();
    expect(container.read(prototypeProvider).breathingCycles, 1);
    await tester.tap(find.text('Pause'));
    await tester.pump();
    await tapVisible(tester, find.text('Restart'));
    expect(find.text('0 cycles completed'), findsOneWidget);
    expect(find.text('Inhale'), findsOneWidget);
  });
  testWidgets(
    'comparison uses local partner and profile and premium never checks out',
    (tester) async {
      final container = await launchPrototype(
        tester,
        route: '/compatibility-result',
      );
      container
          .read(prototypeProvider.notifier)
          .setProfile(
            UserProfile(name: 'Nova', birthDate: DateTime(1994, 10, 14)),
          );
      container
          .read(prototypeProvider.notifier)
          .setPartner(
            UserProfile(name: 'Avery', birthDate: DateTime(1993, 3, 2)),
          );
      await settlePrototype(tester);
      expect(find.text('Nova & Avery'), findsOneWidget);
      container.read(routerProvider).go('/premium');
      await settlePrototype(tester);
      final cta = find.widgetWithText(FilledButton, 'Coming soon');
      await tester.ensureVisible(cta);
      expect(tester.widget<FilledButton>(cta).onPressed, isNull);
      expect(container.read(prototypeProvider).partner.name, 'Avery');
    },
  );
}
