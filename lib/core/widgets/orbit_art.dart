import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

enum OrbitStyle { zodiac, connection, calm }

/// Original vector artwork; deliberately decorative, never a calculated chart.
class OrbitArt extends StatelessWidget {
  const OrbitArt({super.key, this.style = OrbitStyle.zodiac, this.size = 200});
  final OrbitStyle style;
  final double size;
  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _OrbitPainter(style)),
    ),
  );
}

class _OrbitPainter extends CustomPainter {
  _OrbitPainter(this.style);
  final OrbitStyle style;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * .42;
    final ink = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .8
      ..color = AppColors.lavender.withValues(alpha: .5);
    if (style == OrbitStyle.connection) {
      canvas.drawCircle(center.translate(-radius * .35, 0), radius * .74, ink);
      canvas.drawCircle(center.translate(radius * .35, 0), radius * .74, ink);
      canvas.drawCircle(center, 3, Paint()..color = AppColors.gold);
      return;
    }
    canvas.drawCircle(center, radius, ink);
    canvas.drawCircle(center, radius * .78, ink);
    canvas.drawCircle(
      center,
      radius * .46,
      ink..color = AppColors.lavender.withValues(alpha: .2),
    );
    if (style == OrbitStyle.calm) {
      for (var i = 0; i < 6; i++) {
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(i * math.pi / 3);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(0, -radius * .25),
            width: radius * .6,
            height: radius,
          ),
          ink,
        );
        canvas.restore();
      }
    } else {
      for (var i = 0; i < 12; i++) {
        final angle = i * math.pi / 6;
        final direction = Offset(math.cos(angle), math.sin(angle));
        canvas.drawLine(
          center + direction * radius * .78,
          center + direction * radius,
          ink,
        );
      }
      final points = <Offset>[
        center + Offset(-radius * .35, -radius * .22),
        center + Offset(radius * .12, -radius * .42),
        center + Offset(radius * .33, radius * .1),
        center + Offset(-radius * .12, radius * .38),
      ];
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path, ink..color = AppColors.gold.withValues(alpha: .65));
      for (final point in points) {
        canvas.drawCircle(point, 2.5, Paint()..color = AppColors.gold);
      }
    }
    canvas.drawCircle(
      center.translate(radius * .92, -radius * .38),
      3.5,
      Paint()..color = AppColors.gold,
    );
  }

  @override
  bool shouldRepaint(_OrbitPainter oldDelegate) => style != oldDelegate.style;
}
