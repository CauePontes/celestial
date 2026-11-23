import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});
  @override
  ConsumerState<CreatePostScreen> createState() => _CreateState();
}

class _CreateState extends ConsumerState<CreatePostScreen> {
  final form = GlobalKey<FormState>();
  final title = TextEditingController(), body = TextEditingController();
  int category = 0;
  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.createPost,
    children: [
      DemoNotice(text: context.l.localPostNotice),
      const SizedBox(height: 24),
      FilterStrip(
        labels: [context.l.astrology, context.l.wellness, context.l.journal],
        selected: category,
        onSelected: (i) => setState(() => category = i),
      ),
      const SizedBox(height: 24),
      Form(
        key: form,
        child: Column(
          children: [
            TextFormField(
              key: const Key('post-title'),
              controller: title,
              maxLength: 120,
              decoration: InputDecoration(labelText: context.l.postTitle),
              validator: (v) => v == null || v.trim().isEmpty
                  ? context.l.requiredField
                  : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key('post-body'),
              controller: body,
              minLines: 6,
              maxLines: 12,
              maxLength: 2000,
              decoration: InputDecoration(
                labelText: context.l.postBody,
                alignLabelWithHint: true,
              ),
              validator: (v) => v == null || v.trim().isEmpty
                  ? context.l.requiredField
                  : null,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: context.l.publish,
              onPressed: () {
                if (!form.currentState!.validate()) return;
                final state = ref.read(prototypeProvider),
                    controller = ref.read(prototypeProvider.notifier);
                controller.addPost(
                  CommunityPost(
                    id: controller.nextId(),
                    author: state.profile.name.isEmpty
                        ? context.l.explorer
                        : state.profile.name,
                    title: title.text.trim(),
                    body: body.text.trim(),
                    category: category,
                    isLocal: true,
                  ),
                );
                context.canPop() ? context.pop() : context.go('/community');
              },
            ),
          ],
        ),
      ),
    ],
  );
}

class ReportPostScreen extends StatefulWidget {
  const ReportPostScreen({super.key, required this.id});
  final String id;
  @override
  State<ReportPostScreen> createState() => _ReportState();
}

class _ReportState extends State<ReportPostScreen> {
  int? reason;
  bool submitted = false;
  @override
  Widget build(BuildContext context) => PageFrame(
    title: context.l.reportPost,
    children: [
      Text(
        submitted ? context.l.reportConfirmation : context.l.reportWhy,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 24),
      if (!submitted) ...[
        RadioGroup<int>(
          groupValue: reason,
          onChanged: (v) => setState(() => reason = v),
          child: Column(
            children: [
              for (var i = 0; i < 3; i++)
                RadioListTile(
                  value: i,
                  title: Text(
                    [context.l.spam, context.l.unkind, context.l.misleading][i],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: context.l.report,
          onPressed: reason == null
              ? null
              : () => setState(() => submitted = true),
        ),
      ] else
        PrimaryButton(
          label: context.l.done,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/community'),
        ),
      const SizedBox(height: 24),
      DemoNotice(text: context.l.localPostNotice),
    ],
  );
}
