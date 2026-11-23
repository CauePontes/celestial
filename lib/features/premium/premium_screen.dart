import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/premium_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../app/theme/app_colors.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/orbital_crest.dart';
import '../../core/widgets/stitch_layout.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});
  @override
  ConsumerState<PremiumScreen> createState() => _PremiumState();
}

class _PremiumState extends ConsumerState<PremiumScreen> {
  int tier = 0;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final plans = ref.watch(premiumRepositoryProvider).plans(l);
    final usd = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    final benefits = [
      (Icons.star_border, l.fullChartBenefit, l.fullChartBenefitBody),
      (Icons.join_inner, l.compatibilityBenefit, l.compatibilityBenefitBody),
      (Icons.spa_outlined, l.wellnessBenefit, l.wellnessBenefitBody),
      (Icons.timelapse, l.calendarBenefit, l.calendarBenefitBody),
      (Icons.nights_stay_outlined, l.quietBenefit, l.quietBenefitBody),
    ];
    return PageFrame(
      title: l.plus,
      children: [
        const Center(child: OrbitalCrest(size: 160, star: true)),
        Center(child: Kicker(l.sanctuaryLabel)),
        const SizedBox(height: 12),
        Center(
          child: Text(
            l.unlockCosmos,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 16),
        Text(l.subscriptionBody, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        PhotoCard(
          asset: 'assets/stitch/11__celestial_plus_subscription_1.jpg',
          title: l.harmonicCycle,
          subtitle: l.preview,
          height: 140,
        ),
        const SizedBox(height: 24),
        StitchCard(
          padding: 4,
          child: Column(
            children: [
              for (var i = 0; i < benefits.length; i++) ...[
                MenuRow(
                  icon: benefits[i].$1,
                  title: benefits[i].$2,
                  subtitle: benefits[i].$3,
                  gold: true,
                ),
                if (i < benefits.length - 1)
                  const Divider(indent: 16, endIndent: 16),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        RadioGroup<int>(
          groupValue: tier,
          onChanged: (v) => setState(() => tier = v ?? 0),
          child: Column(
            children: [
              PlanCard(
                value: 0,
                title: l.annual,
                subtitle: '${l.billedAnnually} · ${l.saveHalf}',
                price: '${usd.format(plans[1].annualUsd)} ${l.perYear}',
                selected: tier == 0,
              ),
              const SizedBox(height: 12),
              PlanCard(
                value: 1,
                title: l.monthlyAccess,
                subtitle: l.flexibleMonthly,
                price: '${usd.format(plans[1].monthlyUsd)} ${l.perMonth}',
                selected: tier == 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(label: l.comingSoon),
        const SizedBox(height: 16),
        DemoNotice(text: l.paymentNotice),
        SectionTitle(l.comparePlans),
        AdaptiveGrid(
          columns: 3,
          children: [
            _TierCard(
              title: l.free,
              price: usd.format(plans[0].monthlyUsd),
              body: l.freeBody,
            ),
            _TierCard(
              title: l.premium,
              price: usd.format(plans[1].monthlyUsd),
              body: l.premiumBodyPlan,
            ),
            _TierCard(
              title: l.premiumPlus,
              price: usd.format(plans[2].monthlyUsd),
              body: l.plusBodyPlan,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          children: [
            TextButton(
              onPressed: () => context.push('/privacy'),
              child: Text(l.terms),
            ),
            TextButton(
              onPressed: () => context.push('/privacy'),
              child: Text(l.privacy),
            ),
            TextButton(
              onPressed: () => context.push('/credits'),
              child: Text(l.credits),
            ),
          ],
        ),
      ],
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.value,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.selected,
  });
  final int value;
  final String title, subtitle, price;
  final bool selected;
  @override
  Widget build(BuildContext context) => StitchCard(
    elevated: selected,
    padding: 4,
    child: RadioListTile<int>(
      value: value,
      title: Text(title),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          '$subtitle\n$price',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
      contentPadding: const EdgeInsets.all(12),
    ),
  );
}

class _TierCard extends StatelessWidget {
  const _TierCard({
    required this.title,
    required this.price,
    required this.body,
  });
  final String title, price, body;
  @override
  Widget build(BuildContext context) => StitchCard(
    padding: 16,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Text(price, style: const TextStyle(color: AppColors.gold)),
        const SizedBox(height: 12),
        Text(body, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}

class CreditsScreen extends ConsumerWidget {
  const CreditsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledger = ref.watch(premiumRepositoryProvider).ledger(context.l);
    final balance = ledger.fold<int>(0, (sum, entry) => sum + entry.amount);
    return PageFrame(
      title: context.l.credits,
      children: [
        const PreviewBadge(),
        const SizedBox(height: 24),
        StitchCard(
          child: Column(
            children: [
              Text(
                balance.toString(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(context.l.creditsBody, textAlign: TextAlign.center),
            ],
          ),
        ),
        SectionTitle(context.l.creditHistory),
        StitchCard(
          padding: 0,
          child: Column(
            children: [
              for (final entry in ledger)
                MenuRow(
                  icon: entry.amount > 0
                      ? Icons.add_circle_outline
                      : Icons.description_outlined,
                  title: entry.title,
                  trailing: Text(
                    (entry.amount > 0 ? '+' : '') + entry.amount.toString(),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(context.l.paymentNotice),
      ],
    );
  }
}
