import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animo/models/base_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';

class ExploreView extends ConsumerWidget {
  const ExploreView({
    super.key,
    required this.mediaType,
  });

  final MediaType mediaType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFeedProvider(type: mediaType)).when(
          skipLoadingOnRefresh: false,
          data: (data) {
            return RefreshIndicator(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => data[index].build(),
                ),
                onRefresh: () => Future.sync(
                      () => ref.invalidate(getFeedProvider(type: mediaType)),
                    ));
          },
          error: (error, stackTrace) {
            return ErrorView(
              message: getError(error).message,
              onRetry: () => ref.invalidate(getFeedProvider(type: mediaType)),
            );
          },
          loading: () => const Loader(),
        );
  }
}
