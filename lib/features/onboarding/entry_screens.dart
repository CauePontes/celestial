import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/orbital_crest.dart';
import '../../core/widgets/stitch_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(milliseconds: 650), () {
      if (mounted) context.go('/welcome');
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CosmicBackground(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const OrbitalCrest(size: 180),
            Text(
              context.l.appName.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(letterSpacing: 5),
            ),
          ],
        ),
      ),
    ),
  );
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CosmicBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, c) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 480,
                  minHeight: (c.maxHeight - 64).clamp(0, double.infinity),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          context.l.appName.toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(letterSpacing: 5),
                        ),
                        const SizedBox(height: 6),
                        Kicker(context.l.observatory),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: OrbitalCrest(size: 280),
                    ),
                    Text(
                      context.l.welcomeTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 20),
                    Text(context.l.welcomeBody, textAlign: TextAlign.center),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      label: context.l.getStarted,
                      onPressed: () => context.push('/intro'),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => context.push('/sign-in'),
                      child: Text(context.l.existingAccount),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  @override
  State<IntroScreen> createState() => _IntroState();
}

class _IntroState extends State<IntroScreen> {
  final controller = PageController();
  int index = 0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final titles = [l.introOne, l.introTwo, l.introThree];
    return PageFrame(
      title: l.appName,
      actions: const [],
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .55,
          child: PageView.builder(
            controller: controller,
            onPageChanged: (i) => setState(() => index = i),
            itemCount: 3,
            itemBuilder: (context, i) => SingleChildScrollView(
              child: Column(
                children: [
                  OrbitalCrest(size: 220, connection: i == 1, star: i == 2),
                  const SizedBox(height: 20),
                  Text(
                    titles[i],
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(l.introBody, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < 3; i++)
                Container(
                  width: index == i ? 24 : 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: index == i ? AppColors.lavender : AppColors.border,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        PrimaryButton(
          label: index == 2 ? l.continueLabel : l.next,
          onPressed: () {
            if (index == 2) {
              context.push('/sign-in');
            } else {
              controller.nextPage(
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                curve: Curves.easeOut,
              );
            }
          },
        ),
      ],
    );
  }
}
