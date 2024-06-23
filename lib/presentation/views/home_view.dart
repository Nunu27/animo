import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/presentation/controllers/meta_controller.dart';
import 'package:animo/presentation/views/error_view.dart';
import 'package:animo/presentation/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  final MediaType mediaType;
  const HomeView({super.key, required this.mediaType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getFeedProvider(mediaType)).when(
          data: (data) => const Text('daat'),
          error: (error, stackTrace) => ErrorView(
            message: error.toString(),
            onRetry: () {
              ref.invalidate(getFeedProvider(mediaType));
            },
          ),
          loading: () => const Loader(),
        );
  }
}
