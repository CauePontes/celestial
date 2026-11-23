import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class BirthDetailsScreen extends ConsumerStatefulWidget {
  const BirthDetailsScreen({
    super.key,
    this.edit = false,
    this.partner = false,
  });
  final bool edit, partner;
  @override
  ConsumerState<BirthDetailsScreen> createState() => _BirthState();
}

class _BirthState extends ConsumerState<BirthDetailsScreen> {
  final form = GlobalKey<FormState>();
  late TextEditingController name, city;
  DateTime? date;
  TimeOfDay? time;
  bool unknown = false;
  bool initialized = false;
  bool dateError = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (initialized) return;
    initialized = true;
    final profile = widget.partner
        ? ref.read(prototypeProvider).partner
        : ref.read(prototypeProvider).profile;
    name = TextEditingController(
      text: profile.name.isEmpty
          ? (widget.partner ? '' : context.l.sampleName)
          : profile.name,
    );
    city = TextEditingController(
      text: profile.city.isEmpty ? context.l.sampleCity : profile.city,
    );
    date =
        profile.birthDate ??
        (widget.edit || widget.partner ? null : DateTime(1994, 10, 14));
    time = profile.birthMinutes == null
        ? (widget.partner ? null : const TimeOfDay(hour: 6, minute: 42))
        : TimeOfDay(
            hour: profile.birthMinutes! ~/ 60,
            minute: profile.birthMinutes! % 60,
          );
    unknown = profile.unknownTime;
  }

  @override
  void dispose() {
    name.dispose();
    city.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return PageFrame(
      title: widget.partner
          ? l.partnerDetails
          : (widget.edit ? l.editProfile : l.stepOne),
      actions: const [],
      children: [
        const SizedBox(height: 12),
        const CircleAvatar(
          radius: 24,
          child: Icon(Icons.blur_circular_outlined, color: Color(0xFFDABD89)),
        ),
        const SizedBox(height: 24),
        Text(
          widget.partner ? l.partnerDetails : l.birthTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 12),
        Text(widget.partner ? l.comparisonDemo : l.birthBody),
        const SizedBox(height: 20),
        DemoNotice(text: l.demoOnly),
        const SizedBox(height: 24),
        Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                key: const Key('profile-name'),
                controller: name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: widget.partner ? l.partnerName : l.fullName,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (v) =>
                    !widget.partner && (v == null || v.trim().isEmpty)
                    ? l.requiredField
                    : null,
              ),
              const SizedBox(height: 20),
              _PickerField(
                label: l.birthDate,
                value: date == null
                    ? l.chooseDate
                    : DateFormat.yMMMMd(l.localeName).format(date!),
                icon: Icons.calendar_today_outlined,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date ?? DateTime(1994, 10, 14),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      date = picked;
                      dateError = false;
                    });
                  }
                },
              ),
              if (dateError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l.requiredField,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Opacity(
                opacity: unknown ? .45 : 1,
                child: _PickerField(
                  label: '${l.birthTime} · ${l.optional}',
                  value: time == null
                      ? l.chooseTime
                      : MaterialLocalizations.of(
                          context,
                        ).formatTimeOfDay(time!, alwaysUse24HourFormat: false),
                  icon: Icons.schedule,
                  onTap: unknown
                      ? null
                      : () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime:
                                time ?? const TimeOfDay(hour: 12, minute: 0),
                          );
                          if (picked != null) setState(() => time = picked);
                        },
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.unknownTime),
                value: unknown,
                onChanged: (v) => setState(() => unknown = v),
              ),
              if (unknown)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    l.unknownTimeHelp,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              if (!widget.partner)
                TextFormField(
                  key: const Key('profile-city'),
                  controller: city,
                  decoration: InputDecoration(
                    labelText: l.birthplace,
                    prefixIcon: const Icon(Icons.location_on_outlined),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? l.requiredField : null,
                ),
              const SizedBox(height: 36),
              PrimaryButton(
                label: widget.partner
                    ? l.compare
                    : (widget.edit ? l.save : l.continueLabel),
                onPressed: () {
                  final valid = form.currentState!.validate();
                  setState(() => dateError = date == null);
                  if (!valid || date == null) return;
                  final profile = UserProfile(
                    name: name.text.trim(),
                    city: city.text.trim(),
                    birthDate: date,
                    birthMinutes: unknown || time == null
                        ? null
                        : time!.hour * 60 + time!.minute,
                    unknownTime: unknown,
                  );
                  final controller = ref.read(prototypeProvider.notifier);
                  if (widget.partner) {
                    controller.setPartner(profile);
                    context.push('/compatibility-result');
                  } else {
                    controller.setProfile(profile);
                    if (widget.edit) {
                      context.canPop() ? context.pop() : context.go('/profile');
                    } else {
                      context.push('/interests');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });
  final String label, value;
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: StitchCard(
      padding: 16,
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
          const Icon(Icons.expand_more),
        ],
      ),
    ),
  );
}
