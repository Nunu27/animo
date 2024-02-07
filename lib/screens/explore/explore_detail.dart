import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/cover_card_compact_gridview.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';
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
    final mediaProvider = ref.read(getMediaProvider(mediaType));
    return mediaProvider.filter({'sort': filter});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: _handleSearchType(ref),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data;
            return CoverCardCompactGridView(
              data: data,
              column: 3,
            );
          } else if (snapshot.hasError) {
            return ErrorView(message: snapshot.error.toString());
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
