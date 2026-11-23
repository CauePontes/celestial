import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class BreathingExerciseScreen extends ConsumerStatefulWidget {
  const BreathingExerciseScreen({super.key, this.pattern = 'calm'});
  final String pattern;
  @override
  ConsumerState<BreathingExerciseScreen> createState() => _BreathingState();
}

class _BreathingState extends ConsumerState<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<int> durations;
  bool active = false;
  int completed = 0;
  @override
  void initState() {
    super.initState();
    durations = widget.pattern == 'box'
        ? [4, 4, 4, 4]
        : widget.pattern == 'lunar'
        ? [4, 0, 6]
        : [4, 7, 8];
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: durations.reduce((a, b) => a + b)),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && active) {
        setState(() => completed++);
        ref.read(prototypeProvider.notifier).addBreathingCycle();
        controller.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  (int, double, int) phase() {
    final total = durations.reduce((a, b) => a + b);
    var elapsed = controller.value * total;
    for (var i = 0; i < durations.length; i++) {
      if (elapsed < durations[i] || i == durations.length - 1) {
        return (
          i,
          durations[i] == 0 ? 0 : elapsed / durations[i],
          (durations[i] - elapsed).ceil().clamp(0, 30),
        );
      }
      elapsed -= durations[i];
    }
    return (0, 0, durations.first);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final title = widget.pattern == 'box'
        ? l.boxBreathing
        : widget.pattern == 'lunar'
        ? l.lunarResonance
        : l.calmBreath;
    return PageFrame(
      title: title,
      children: [
        Text(l.breathingHelp),
        const SizedBox(height: 24),
        AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final (index, progress, remaining) = phase();
            final scale = MediaQuery.disableAnimationsOf(context)
                ? .85
                : index == 0
                ? .65 + progress * .35
                : index == 2
                ? 1 - progress * .35
                : index == 1
                ? 1.0
                : .65;
            final labels = [l.inhale, l.hold, l.exhale, l.rest];
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 280,
                    width: 280,
                    child: Center(
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withValues(alpha: .2),
                              ],
                            ),
                            border: Border.all(
                              color: AppColors.lavender.withValues(alpha: .55),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.air,
                              size: 60,
                              color: AppColors.lavender,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      labels[index],
                      key: const Key('breathing-phase'),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$remaining',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        Center(child: Text('$completed ${l.cycles}')),
        const SizedBox(height: 24),
        PrimaryButton(
          key: const Key('breathing-toggle'),
          label: active ? l.pause : l.start,
          onPressed: () {
            setState(() => active = !active);
            if (active) {
              controller.forward();
            } else {
              controller.stop();
            }
          },
        ),
        const SizedBox(height: 12),
        SecondaryButton(
          label: l.restart,
          onPressed: () {
            controller.reset();
            setState(() {
              active = false;
              completed = 0;
            });
          },
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            final (index, _, _) = phase();
            final total = durations.reduce((a, b) => a + b);
            final boundary =
                durations.take(index + 1).fold<int>(0, (a, b) => a + b) / total;
            if (boundary >= 1) {
              controller.value = 1;
            } else {
              controller.value = boundary + .0001;
            }
          },
          child: Text(l.next),
        ),
        const SizedBox(height: 24),
        FilterStrip(
          labels: [l.calmBreath, l.boxBreathing, l.lunarResonance],
          selected: widget.pattern == 'box'
              ? 1
              : widget.pattern == 'lunar'
              ? 2
              : 0,
          onSelected: (i) => context.pushReplacement(
            '/breathing?pattern=${const ['calm', 'box', 'lunar'][i]}',
          ),
        ),
      ],
    );
  }
}
