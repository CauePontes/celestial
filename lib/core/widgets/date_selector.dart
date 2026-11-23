import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../utils/context_extensions.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.date,
    required this.onPrevious,
    required this.onNext,
    this.trailing,
  });
  final DateTime date;
  final VoidCallback onPrevious, onNext;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      IconButton(
        tooltip: context.l.previous,
        onPressed: onPrevious,
        icon: const Icon(Icons.chevron_left),
      ),
      Expanded(
        child: Text(
          DateFormat.yMMMMd(context.l.localeName).format(date),
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.gold),
        ),
      ),
      IconButton(
        tooltip: context.l.nextDate,
        onPressed: onNext,
        icon: const Icon(Icons.chevron_right),
      ),
      ?trailing,
    ],
  );
}
