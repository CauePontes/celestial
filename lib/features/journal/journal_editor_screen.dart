import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import 'mood_selector.dart';

class JournalEditorScreen extends ConsumerStatefulWidget {
  const JournalEditorScreen({super.key, this.id});
  final String? id;
  @override
  ConsumerState<JournalEditorScreen> createState() => _EditorState();
}

class _EditorState extends ConsumerState<JournalEditorScreen> {
  final form = GlobalKey<FormState>();
  late TextEditingController title, body;
  JournalEntry? entry;
  late int mood;
  @override
  void initState() {
    super.initState();
    final state = ref.read(prototypeProvider);
    final matches = state.journal.where((e) => e.id == widget.id);
    entry = matches.isEmpty ? null : matches.first;
    title = TextEditingController(text: entry?.title ?? '');
    body = TextEditingController(text: entry?.body ?? '');
    mood = entry?.mood ?? state.mood;
  }

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return PageFrame(
      title: entry == null ? l.newEntry : l.editEntry,
      children: [
        Text(l.journalPrompt),
        const SizedBox(height: 24),
        MoodSelector(value: mood, onChanged: (i) => setState(() => mood = i)),
        const SizedBox(height: 24),
        Form(
          key: form,
          child: Column(
            children: [
              TextFormField(
                key: const Key('journal-title'),
                controller: title,
                maxLength: 120,
                decoration: InputDecoration(labelText: l.entryTitle),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? l.requiredField : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('journal-body'),
                controller: body,
                minLines: 7,
                maxLines: 16,
                maxLength: 5000,
                decoration: InputDecoration(
                  labelText: l.entryBody,
                  alignLabelWithHint: true,
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? l.requiredField : null,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: l.save,
                onPressed: () {
                  if (!form.currentState!.validate()) return;
                  final controller = ref.read(prototypeProvider.notifier);
                  controller.saveJournal(
                    JournalEntry(
                      id: entry?.id ?? controller.nextId(),
                      title: title.text.trim(),
                      body: body.text.trim(),
                      mood: mood,
                      date: entry?.date ?? DateTime.now(),
                    ),
                  );
                  showMessage(context, l.entrySaved);
                  context.canPop() ? context.pop() : context.go('/journal');
                },
              ),
              if (entry != null) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: Text(l.delete),
                        content: Text(entry!.title),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(c, false),
                            child: Text(l.cancel),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(c, true),
                            child: Text(l.delete),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true && context.mounted) {
                      ref
                          .read(prototypeProvider.notifier)
                          .deleteJournal(entry!.id);
                      showMessage(context, l.entryDeleted);
                      context.canPop() ? context.pop() : context.go('/journal');
                    }
                  },
                  child: Text(l.delete),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        DemoNotice(text: l.demoOnly),
      ],
    );
  }
}
