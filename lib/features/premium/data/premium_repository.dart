import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';

class PlanDefinition {
  const PlanDefinition(
    this.id,
    this.title,
    this.description,
    this.monthlyUsd,
    this.annualUsd,
  );
  final String id, title, description;
  final double monthlyUsd, annualUsd;
}

class CreditEntry {
  const CreditEntry(this.title, this.amount);
  final String title;
  final int amount;
}

abstract interface class PremiumRepository {
  List<PlanDefinition> plans(AppLocalizations l);
  List<CreditEntry> ledger(AppLocalizations l);
}

class MockPremiumRepository implements PremiumRepository {
  const MockPremiumRepository();
  @override
  List<PlanDefinition> plans(AppLocalizations l) => List.unmodifiable([
    PlanDefinition('free', l.free, l.freeBody, 0, 0),
    PlanDefinition('premium', l.premium, l.premiumBodyPlan, 9.99, 59.99),
    PlanDefinition('plus', l.premiumPlus, l.plusBodyPlan, 19.99, 119.99),
  ]);
  @override
  List<CreditEntry> ledger(AppLocalizations l) => List.unmodifiable([
    CreditEntry(l.welcomeCredit, 150),
    CreditEntry(l.reportCredit, -30),
  ]);
}

final premiumRepositoryProvider = Provider<PremiumRepository>(
  (ref) => const MockPremiumRepository(),
);
