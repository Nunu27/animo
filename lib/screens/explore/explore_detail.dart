import 'package:animo/constants/constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/failure.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/paginated_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExploreDetail extends ConsumerStatefulWidget {
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

  @override
  ConsumerState<ExploreDetail> createState() => _ExploreDetailState();
}

class _ExploreDetailState extends ConsumerState<ExploreDetail> {
  final PagingController<int, MediaBasic> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  Future<PaginatedData<MediaBasic>> _fetch(int page) {
    final mediaRepository = ref.read(mediaRepositoryProvider);
    return mediaRepository.explore(
      widget.mediaType,
      widget.path,
      widget.options,
      page: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PaginatedView(
        pagingController: pagingController,
        fetcher: _fetch,
        child: PagedGridView(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<MediaBasic>(
            firstPageErrorIndicatorBuilder: (context) =>
                ErrorView(message: (pagingController.error as Failure).message),
            itemBuilder: (context, item, index) => CoverCardCompact(
              media: item,
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: Constants.coverRatio,
            crossAxisCount: 3,
          ),
        ),
      ),
    );
  }
}
