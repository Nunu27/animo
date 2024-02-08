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
    required this.filter,
    required this.mediaType,
    required this.title,
  });

  final MediaType mediaType;
  final String filter;
  final String title;

  Future<PaginatedData<MediaBasic>>? _handleSearchType(WidgetRef ref) {
    final mediaRepository = ref.read(mediaRepositoryProvider);
    return mediaRepository.filter(mediaType, {'sort': filter});
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
