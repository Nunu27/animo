import 'dart:developer';

import 'package:animo/presentation/shared/views/error_view.dart';
import 'package:animo/presentation/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatcherView<T> extends ConsumerWidget {
  final ProviderListenable<AsyncValue<T>> provider;
  final Widget Function(T data) onData;

  const WatcherView({super.key, required this.provider, required this.onData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: onData,
          skipLoadingOnRefresh: false,
          error: (error, stackTrace) {
            log(error.toString(), stackTrace: stackTrace);

            return ErrorView(
              error: error,
              onRetry: () {
                ref.invalidate(provider as ProviderOrFamily);
              },
            );
          },
          loading: () => const Loader(),
        );
  }
}
