import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/catalog_view.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';
import 'community_feed_screen.dart';

class CommunityPostScreen extends ConsumerStatefulWidget {
  const CommunityPostScreen({super.key, required this.id});
  final String id;
  @override
  ConsumerState<CommunityPostScreen> createState() => _PostState();
}

class _PostState extends ConsumerState<CommunityPostScreen> {
  final comment = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(prototypeProvider), l = context.l;
    return PageFrame(
      title: l.communityFeed,
      children: [
        CatalogView(
          builder: (catalog) {
            final matches = [...state.posts, ...catalog.posts].where(
              (p) => p.id == widget.id && !state.blocked.contains(p.author),
            );
            if (matches.isEmpty) {
              return EmptyState(title: l.noResults, body: l.noEntriesBody);
            }
            final post = matches.first;
            final comments = [
              DemoComment('Jordan', l.mockComment),
              ...state.comments[post.id] ?? [],
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommunityPostCard(post: post),
                SectionTitle(l.comments),
                for (final c in comments)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StitchCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.author,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(c.body),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Form(
                  key: form,
                  child: TextFormField(
                    key: const Key('comment-body'),
                    controller: comment,
                    maxLength: 500,
                    maxLines: 3,
                    decoration: InputDecoration(labelText: l.addComment),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? l.requiredField : null,
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: l.sendComment,
                  onPressed: () {
                    if (!form.currentState!.validate()) return;
                    ref
                        .read(prototypeProvider.notifier)
                        .addComment(
                          post.id,
                          DemoComment(
                            state.profile.name.isEmpty
                                ? l.explorer
                                : state.profile.name,
                            comment.text.trim(),
                          ),
                        );
                    comment.clear();
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    ref.read(prototypeProvider.notifier).block(post.author);
                    showMessage(context, l.blocked);
                    context.canPop() ? context.pop() : context.go('/community');
                  },
                  child: Text(l.block),
                ),
                const SizedBox(height: 16),
                DemoNotice(text: l.localPostNotice),
              ],
            );
          },
        ),
      ],
    );
  }
}
