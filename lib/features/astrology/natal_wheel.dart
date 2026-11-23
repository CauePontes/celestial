import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/context_extensions.dart';

class NatalWheel extends StatefulWidget {
  const NatalWheel({
    super.key,
    this.size = 320,
    this.selected = -1,
    this.simple = false,
  });
  final double size;
  final int selected;
  final bool simple;
  @override
  State<NatalWheel> createState() => _WheelState();
}

class _WheelState extends State<NatalWheel> {
  double angle = 0;
  @override
  Widget build(BuildContext context) => Semantics(
    label: context.l.chartNotice,
    child: Column(
      children: [
        LayoutBuilder(
          builder: (context, c) => GestureDetector(
            onPanUpdate: (d) => setState(() => angle += d.delta.dx * .008),
            child: Transform.rotate(
              angle: angle,
              child: SizedBox.square(
                dimension: math.min(widget.size, c.maxWidth),
                child: CustomPaint(
                  painter: _WheelPainter(widget.selected, widget.simple),
                ),
              ),
            ),
          ),
        ),
        if (!widget.simple)
          IconButton(
            tooltip: context.l.restart,
            onPressed: () => setState(() => angle = 0),
            icon: const Icon(Icons.rotate_left, size: 20),
          ),
      ],
    ),
  );
}

class _WheelPainter extends CustomPainter {
  _WheelPainter(this.selected, this.simple);
  final int selected;
  final bool simple;
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero), r = size.shortestSide * .46;
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .75
      ..color = AppColors.lavender.withValues(alpha: .25);
    for (final ratio in [1.0, .85, .58, .34, .16]) {
      canvas.drawCircle(c, r * ratio, p);
    }
    for (var i = 0; i < 12; i++) {
      final a = i * math.pi / 6, dir = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(c + dir * r * .34, c + dir * r, p);
      if (!simple) {
        _text(
          canvas,
          const ['♈', '♉', '♊', '♋', '♌', '♍', '♎', '♏', '♐', '♑', '♒', '♓'][i],
          c + dir * r * 1.01,
          AppColors.lavender,
          10,
        );
      }
    }
    final nodes = [
      c + Offset(0, -r * .82),
      c + Offset(r * .67, r * .36),
      c + Offset(-r * .59, r * .26),
      c + Offset(r * .44, -r * .5),
      c + Offset(-r * .14, r * .73),
      c + Offset(r * .2, r * .78),
      c + Offset(-r * .43, -r * .65),
      c + Offset(-r * .58, -r * .31),
      c + Offset(r * .76, -r * .12),
      c + Offset(-r * .2, r * .5),
    ];
    final path = Path()
      ..moveTo(nodes[0].dx, nodes[0].dy)
      ..lineTo(nodes[1].dx, nodes[1].dy)
      ..lineTo(nodes[2].dx, nodes[2].dy)
      ..close();
    canvas.drawPath(path, p..color = AppColors.gold.withValues(alpha: .5));
    if (!simple) {
      for (final pair in [(3, 4), (4, 6), (6, 3), (1, 3), (5, 7)]) {
        canvas.drawLine(
          nodes[pair.$1],
          nodes[pair.$2],
          p..color = AppColors.lavender.withValues(alpha: .4),
        );
      }
    }
    final glyphs = ['☉', '☽', '↑', '♀', '♂', '☿', '♃', '♄', '♆', '♇'];
    for (var i = 0; i < (simple ? 3 : 10); i++) {
      final alpha = selected < 0 || selected == i ? 1.0 : .3;
      canvas.drawCircle(
        nodes[i],
        simple ? 10 : 8,
        Paint()..color = AppColors.surfaceElevated,
      );
      canvas.drawCircle(
        nodes[i],
        simple ? 10 : 8,
        p
          ..color = (i == 0 ? AppColors.gold : AppColors.lavender).withValues(
            alpha: alpha,
          ),
      );
      _text(
        canvas,
        glyphs[i],
        nodes[i],
        (i == 0 ? AppColors.gold : AppColors.lavender).withValues(alpha: alpha),
        simple ? 13 : 10,
      );
    }
    canvas.drawCircle(c, 5, Paint()..color = AppColors.gold);
  }

  void _text(
    Canvas canvas,
    String text,
    Offset offset,
    Color color,
    double size,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'Noto Symbols',
          fontFamilyFallback: const ['Noto Symbols2'],
          fontSize: size,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, offset - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(_WheelPainter old) =>
      selected != old.selected || simple != old.simple;
}
