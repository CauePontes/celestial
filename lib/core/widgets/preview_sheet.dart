import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'components.dart';

Future<void> showFeaturePreview(
  BuildContext context,
  String title, {
  String? body,
}) => showModalBottomSheet<void>(
  context: context,
  showDragHandle: true,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) {
    final l = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PreviewBadge(),
          const SizedBox(height: 20),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(body ?? l.foundationBody),
          const SizedBox(height: 24),
          PrimaryButton(
            label: l.close,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  },
);
