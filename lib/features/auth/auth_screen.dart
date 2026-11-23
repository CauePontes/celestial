import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/orbital_crest.dart';
import '../../core/widgets/stitch_layout.dart';

enum AuthMode { signIn, signUp, recover }

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, required this.mode});
  final AuthMode mode;
  @override
  ConsumerState<AuthScreen> createState() => _AuthState();
}

class _AuthState extends ConsumerState<AuthScreen> {
  final form = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  bool obscure = true;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final title = switch (widget.mode) {
      AuthMode.signIn => l.signIn,
      AuthMode.signUp => l.signUp,
      AuthMode.recover => l.recoverPassword,
    };
    return PageFrame(
      title: title,
      actions: const [],
      children: [
        const Center(child: OrbitalCrest(size: 160)),
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 16),
        DemoNotice(text: l.authNotice),
        const SizedBox(height: 28),
        Form(
          key: form,
          child: Column(
            children: [
              if (widget.mode == AuthMode.signUp) ...[
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(labelText: l.fullName),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? l.requiredField : null,
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(labelText: l.email),
                validator: (v) =>
                    v != null &&
                        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim())
                    ? null
                    : l.invalidEmail,
              ),
              if (widget.mode != AuthMode.recover) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: password,
                  obscureText: obscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: l.password,
                    suffixIcon: IconButton(
                      tooltip: l.password,
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(
                        obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (v) =>
                      v != null && v.length >= 8 ? null : l.passwordRule,
                ),
              ],
              const SizedBox(height: 28),
              PrimaryButton(
                label: title,
                onPressed: () {
                  if (!form.currentState!.validate()) return;
                  if (widget.mode == AuthMode.recover) {
                    showMessage(context, l.resetNotice);
                  } else {
                    if (widget.mode == AuthMode.signUp) {
                      ref
                          .read(prototypeProvider.notifier)
                          .setProfile(UserProfile(name: name.text.trim()));
                    }
                    context.push('/birth-details');
                  }
                },
              ),
            ],
          ),
        ),
        if (widget.mode == AuthMode.signIn) ...[
          TextButton(
            onPressed: () => context.push('/sign-up'),
            child: Text(l.signUp),
          ),
          TextButton(
            onPressed: () => context.push('/recover'),
            child: Text(l.recoverPassword),
          ),
        ],
        const SizedBox(height: 12),
        SecondaryButton(
          label: l.skip,
          onPressed: () => context.push('/birth-details'),
        ),
      ],
    );
  }
}
