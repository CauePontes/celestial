import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import 'horoscope_reading.dart';

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
  HoroscopeReading getReading(AppLocalizations content, int period);
  Interpretation getHoroscope(AppLocalizations content);
  Interpretation getBirthChartInterpretation(AppLocalizations content);
  Interpretation getNumerologyInterpretation(AppLocalizations content);
  Interpretation getCompatibilityInterpretation(AppLocalizations content);
}

class MockInterpretationRepository implements InterpretationRepository {
  const MockInterpretationRepository();
  @override
  HoroscopeReading getReading(AppLocalizations l, int period) =>
      switch (period) {
        1 => HoroscopeReading(
          l.readingWeeklyTitle,
          l.readingWeekly,
          l.loveWeekly,
          l.careerWeekly,
          l.wellnessWeekly,
        ),
        2 => HoroscopeReading(
          l.readingMonthlyTitle,
          l.readingMonthly,
          l.loveMonthly,
          l.careerMonthly,
          l.wellnessMonthly,
        ),
        _ => HoroscopeReading(
          l.readingDailyTitle,
          l.readingDaily,
          l.loveDaily,
          l.careerDaily,
          l.wellnessDaily,
        ),
      };
  @override
  Interpretation getHoroscope(AppLocalizations content) =>
      Interpretation(title: content.insightTitle, body: content.insightBody);
  @override
  Interpretation getBirthChartInterpretation(AppLocalizations content) =>
      Interpretation(title: content.birthChart, body: content.chartNotice);
  @override
  Interpretation getNumerologyInterpretation(AppLocalizations content) =>
      Interpretation(
        title: content.numerologyReport,
        body: content.numerologyBody,
      );
  @override
  Interpretation getCompatibilityInterpretation(AppLocalizations content) =>
      Interpretation(title: content.compatibility, body: content.loveBody);
}

final interpretationRepositoryProvider = Provider<InterpretationRepository>(
  (ref) => const MockInterpretationRepository(),
);
