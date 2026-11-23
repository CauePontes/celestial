import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../demo/catalog_repository.dart';
import '../models/prototype_models.dart';
import '../utils/context_extensions.dart';
import 'components.dart';

class CatalogView extends ConsumerWidget {
  const CatalogView({super.key, required this.builder});
  final Widget Function(PrototypeCatalog) builder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = context.l.localeName;
    return ref
        .watch(catalogProvider(key))
        .when(
          data: builder,
          loading: () => Semantics(
            label: context.l.loading,
            child: const SurfaceCard(child: LoadingSkeleton()),
          ),
          error: (error, stack) => SurfaceCard(
            child: Column(
              children: [
                Text(context.l.loadError),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: context.l.tryAgain,
                  onPressed: () => ref.invalidate(catalogProvider(key)),
                ),
              ],
            ),
          ),
        );
  }
}
