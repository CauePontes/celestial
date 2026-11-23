import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class OrbitalCrest extends StatelessWidget {
  const OrbitalCrest({
    super.key,
    this.size = 280,
    this.connection = false,
    this.star = false,
  });
  final double size;
  final bool connection, star;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      dimension: size,
      child: CustomPaint(
        painter: _CrestPainter(connection),
        child: Center(
          child: Container(
            width: size * .24,
            height: size * .24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: .65),
                  AppColors.surfaceElevated,
                ],
              ),
            ),
            child: Icon(
              star ? Icons.auto_awesome_outlined : Icons.nightlight_round,
              color: AppColors.gold,
              size: size * .11,
            ),
          ),
        ),
      ),
    ),
  );
}

class _CrestPainter extends CustomPainter {
  _CrestPainter(this.connection);
  final bool connection;
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero), r = size.shortestSide * .44;
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .8
      ..color = AppColors.lavender.withValues(alpha: .3);
    if (connection) {
      for (final offset in [-.28, .28]) {
        final center = c.translate(r * offset, 0);
        canvas.drawCircle(center, r * .74, p);
        _dashes(canvas, center, r * .9, p);
      }
    } else {
      canvas.drawCircle(c, r * .76, p);
      canvas.drawCircle(
        c,
        r * .45,
        p..color = AppColors.gold.withValues(alpha: .45),
      );
      _dashes(
        canvas,
        c,
        r,
        p..color = AppColors.lavender.withValues(alpha: .25),
      );
      for (final angle in [-.4, .56]) {
        canvas.save();
        canvas.translate(c.dx, c.dy);
        canvas.rotate(angle);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: r * 1.85,
            height: r * .83,
          ),
          p
            ..color = (angle < 0 ? AppColors.lavender : AppColors.gold)
                .withValues(alpha: .35),
        );
        canvas.restore();
      }
    }
    for (final node in [(1.0, -1.5), (.84, -.5), (.83, 2.6)]) {
      final o = c + Offset(math.cos(node.$2), math.sin(node.$2)) * r * node.$1;
      canvas.drawCircle(o, 2.5, Paint()..color = AppColors.gold);
    }
  }

  void _dashes(Canvas canvas, Offset c, double r, Paint p) {
    for (var i = 0; i < 60; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r),
        i * math.pi / 30,
        .035,
        false,
        p,
      );
    }
  }

  @override
  bool shouldRepaint(_CrestPainter old) => old.connection != connection;
}
