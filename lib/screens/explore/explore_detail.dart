import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/widgets/cover_card_compact_gridview.dart';
import 'package:animo/widgets/paginated_view.dart';

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

  Future<PaginatedData<MediaBasic>> _fetch(WidgetRef ref, int page) {
    final mediaRepository = ref.read(mediaRepositoryProvider);
    return mediaRepository.explore(
      mediaType,
      path,
      options,
      page: page,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: PaginatedView<MediaBasic>(
        fetcher: (page) => _fetch(ref, page),
        onData: (data) => CoverCardCompactGridView(
          isScrollable: false,
          data: data,
          column: 3,
        ),
      ),
    );
  }
}
