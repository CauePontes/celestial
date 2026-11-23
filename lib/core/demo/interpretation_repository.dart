import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';

class Interpretation {
  const Interpretation({
    required this.title,
    required this.body,
    this.isPreview = true,
  });
  final String title;
  final String body;
  final bool isPreview;
}

abstract interface class InterpretationRepository {
  Interpretation getHoroscope(AppLocalizations content);
  Interpretation getBirthChartInterpretation(AppLocalizations content);
  Interpretation getNumerologyInterpretation(AppLocalizations content);
  Interpretation getCompatibilityInterpretation(AppLocalizations content);
}

class MockInterpretationRepository implements InterpretationRepository {
  const MockInterpretationRepository();
  @override
  Interpretation getHoroscope(AppLocalizations content) =>
      Interpretation(title: content.insightTitle, body: content.insightBody);
  @override
  Interpretation getBirthChartInterpretation(AppLocalizations content) =>
      Interpretation(title: content.birthChart, body: content.chartNotice);
  @override
  Interpretation getNumerologyInterpretation(AppLocalizations content) =>
      Interpretation(title: content.numerology, body: content.foundationBody);
  @override
  Interpretation getCompatibilityInterpretation(AppLocalizations content) =>
      Interpretation(title: content.compatibility, body: content.loveBody);
}

final interpretationRepositoryProvider = Provider<InterpretationRepository>(
  (ref) => const MockInterpretationRepository(),
);
