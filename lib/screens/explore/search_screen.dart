import 'package:animo/constants/constants.dart';
import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/filter_modal.dart';
import 'package:animo/widgets/paginated_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({
    super.key,
    required this.mediaType,
  });

  final MediaType mediaType;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final PagingController<int, MediaBasic> _pagingController =
      PagingController(firstPageKey: 1);
  final TextEditingController _searchController = TextEditingController();

  late MediaType selectedMediaType = widget.mediaType;
  Map<String, dynamic> options = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<PaginatedData<MediaBasic>> _fetch(int page) {
    final mediaRepository = ref.read(mediaRepositoryProvider);

    return mediaRepository.filter(
      selectedMediaType,
      {
        ...options,
        'query': _searchController.text.isEmpty ? null : _searchController.text
      },
      page: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: _searchController.text.isEmpty
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    )
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    ),
              hintText: 'Search',
            ),
            onSubmitted: (value) {
              if (_pagingController.itemList == null) {
                setState(() {});
              } else {
                _pagingController.refresh();
              }
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14)
                  .copyWith(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SegmentedButton(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: MediaType.anime,
                        label: Text('Anime'),
                      ),
                      ButtonSegment(
                        value: MediaType.manga,
                        label: Text('Manga'),
                      ),
                      ButtonSegment(
                        value: MediaType.novel,
                        label: Text('Novel'),
                      ),
                    ],
                    selected: <MediaType>{selectedMediaType},
                    onSelectionChanged: (p0) {
                      options.clear();
                      setState(() {
                        selectedMediaType = p0.first;
                      });
                      _pagingController.refresh();
                    },
                  ),
                  FilledButton.icon(
                    onPressed: () {
                      _showFilterModal(context, theme);
                    },
                    icon: const Icon(Icons.filter_list_rounded),
                    label: const Text('Filter'),
                    style: Theme.of(context).filledButtonTheme.style!.copyWith(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 14,
                            ),
                          ),
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: PaginatedView(
          pagingController: _pagingController,
          fetcher: _fetch,
          child: _searchController.text.isEmpty && options.isEmpty
              ? const ErrorView(message: 'Search something here')
              : PagedGridView(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  showNewPageProgressIndicatorAsGridChild: false,
                  showNewPageErrorIndicatorAsGridChild: false,
                  showNoMoreItemsIndicatorAsGridChild: false,
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<MediaBasic>(
                    newPageErrorIndicatorBuilder: (context) => ErrorView(
                      message: getError(_pagingController.error).message,
                      onRetry: _pagingController.refresh,
                    ),
                    itemBuilder: (context, item, index) => CoverCardCompact(
                      media: item,
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: Constants.coverRatio,
                    crossAxisCount: 3,
                  ),
                ),
        ));
  }

  void _showFilterModal(BuildContext context, ThemeData theme) async {
    final Map<String, dynamic>? data = await CustomBottomModalSheet(
      context: context,
      maxChildExpand: 1,
      children: [
        FilterModal(
          options: options,
          filters: getProviderInfo(selectedMediaType).mediaFilters,
        ),
      ],
    ).showModal();

    if (data != null) {
      options = data;
      if (_pagingController.itemList == null) {
        setState(() {});
      } else {
        _pagingController.refresh();
      }
    }
  }
}
