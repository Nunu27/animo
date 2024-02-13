import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/widgets/cover_card_compact_gridview.dart';
import 'package:animo/widgets/future_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreDetail extends ConsumerWidget {
  const ExploreDetail({
    super.key,
    required this.title,
    required this.path,
    required this.mediaType,
    this.options = const {},
  });

  final String title;
  final String path;
  final MediaType mediaType;
  final Map<String, dynamic> options;

  Future<PaginatedData<MediaBasic>>? _handleSearchType(WidgetRef ref) {
    final mediaRepository = ref.read(mediaRepositoryProvider);
    return mediaRepository.explore(
      mediaType,
      path,
      options,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureView(
        future: _handleSearchType(ref),
        onData: (data) {
          return CoverCardCompactGridView(
            data: data.data,
            column: 3,
          );
        },
      ),
    );
  }
}
