import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../core/demo/prototype_controller.dart';
import '../../core/models/prototype_models.dart';
import '../../core/utils/context_extensions.dart';
import '../../core/widgets/catalog_view.dart';
import '../../core/widgets/components.dart';
import '../../core/widgets/stitch_layout.dart';

class CommunityFeedScreen extends ConsumerStatefulWidget {
  const CommunityFeedScreen({super.key});
  @override
  ConsumerState<CommunityFeedScreen> createState() => _FeedState();
}

class _FeedState extends ConsumerState<CommunityFeedScreen> {
  int filter = 0;
  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final state = ref.watch(prototypeProvider);
    return PageFrame(
      title: l.communityFeed,
      children: [
        DemoNotice(text: l.communityPreview),
        const SizedBox(height: 20),
        PrimaryButton(
          label: l.createPost,
          onPressed: () => context.push('/community/new'),
        ),
        const SizedBox(height: 20),
        FilterStrip(
          labels: [l.all, l.astrology, l.wellness, l.journal],
          selected: filter,
          onSelected: (i) => setState(() => filter = i),
        ),
        const SizedBox(height: 20),
        CatalogView(
          builder: (catalog) {
            final posts = [...state.posts, ...catalog.posts]
                .where(
                  (p) =>
                      !state.blocked.contains(p.author) &&
                      (filter == 0 || p.category == filter - 1),
                )
                .toList();
            if (posts.isEmpty) {
              return EmptyState(title: l.noResults, body: l.noEntriesBody);
            }
            return Column(
              children: [
                for (final post in posts)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CommunityPostCard(post: post),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class CommunityPostCard extends ConsumerWidget {
  const CommunityPostCard({super.key, required this.post});
  final CommunityPost post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(
      prototypeProvider.select((s) => s.likes.contains(post.id)),
    );
    return StitchCard(
      onTap: () => context.push('/community/post/${post.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text(post.author.characters.first),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.author),
                    const SizedBox(height: 6),
                    const PreviewBadge(),
                  ],
                ),
              ),
            ],
          ),
          if (post.title.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(post.title, style: Theme.of(context).textTheme.titleLarge),
          ],
          const SizedBox(height: 16),
          Text(post.body),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              TextButton.icon(
                onPressed: () =>
                    ref.read(prototypeProvider.notifier).toggleLike(post.id),
                icon: Icon(
                  liked ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                ),
                label: Text(liked ? context.l.liked : context.l.like),
              ),
              TextButton(
                onPressed: () => context.push('/community/post/${post.id}'),
                child: Text(context.l.comments),
              ),
              TextButton(
                onPressed: () => context.push('/community/report/${post.id}'),
                child: Text(context.l.report),
              ),
            ],
          ),
          Text(
            post.isLocal
                ? context.l.localPostNotice
                : context.l.communityPreview,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
