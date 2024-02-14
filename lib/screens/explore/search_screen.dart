import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/cover_card_compact_gridview.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/filter_modal.dart';
import 'package:animo/widgets/future_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  late final TextEditingController _searchController;
  late final RefreshController _refreshController;

  late MediaType selectedMediaType;
  late Future<PaginatedData<MediaBasic>>? _future;
  Map<String, dynamic> options = {};
  int currentPage = 1;
  List<MediaBasic> mediaList = [];
  int countDuplicateMedia = 0;

  @override
  void initState() {
    super.initState();
    selectedMediaType = widget.mediaType;
    _searchController = TextEditingController();
    _refreshController = RefreshController(initialRefresh: true);
  }

  Future<PaginatedData<MediaBasic>>? _handleFuture() {
    final mediaRepository = ref.read(mediaRepositoryProvider);
    options['query'] =
        _searchController.text.isEmpty ? null : _searchController.text;

    return mediaRepository.filter(selectedMediaType, options,
        page: currentPage);
  }

  void _loadMoreFuture() {
    currentPage++;
    _future = _handleFuture();
    _updateMediaList();
  }

  void _updateMediaList() async {
    try {
      final data = await _future;
      if (data?.data.isNotEmpty ?? false) {
        mediaList.addAll(data!.data);
      }
    } catch (e) {
      print(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _refreshFuture() {
    currentPage = 1;
    mediaList.clear();
    _future = _handleFuture();
    _updateMediaList();
  }

  void _onRetry() {
    setState(() {
      _future = _handleFuture();
    });
    _updateMediaList();
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
                      _searchController.text = '';
                      setState(() {});
                    },
                  ),
            hintText: 'Search',
          ),
          onSubmitted: (value) {
            _refreshFuture();
            setState(() {});
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
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
                    setState(() {
                      options.clear();
                      selectedMediaType = p0.first;
                    });
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
      body: _searchController.text.isEmpty && options.isEmpty
          ? const ErrorView(message: 'Search something here')
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureView(
                refreshController: _refreshController,
                fullPageLoadingView: mediaList.isEmpty,
                future: _future,
                onRetry: _onRetry,
                onData: (snapshot) {
                  final data = snapshot.data;
                  if (_refreshController.isLoading) {
                    if (data.isNotEmpty) {
                      _refreshController.loadComplete();
                    } else {
                      _refreshController.loadNoData();
                    }
                  }

                  return mediaList.isEmpty
                      ? ErrorView(
                          message:
                              "${selectedMediaType.name} '${_searchController.text}' not found",
                        )
                      : SmartRefresher(
                          controller: _refreshController,
                          enablePullUp: true,
                          enablePullDown: true,
                          onLoading: _loadMoreFuture,
                          onRefresh: _refreshFuture,
                          header: const WaterDropMaterialHeader(),
                          footer: const ClassicFooter(
                            loadStyle: LoadStyle.ShowWhenLoading,
                          ),
                          child: CoverCardCompactGridView(
                            isScrollable: false,
                            data: mediaList,
                            column: 3,
                          ),
                        );
                },
              ),
            ),
    );
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
      _refreshFuture();
    }
  }

  void _checkDuplicateMedia(List<MediaBasic> data) {
    for (MediaBasic element in data) {
      if (mediaList.map((e) => e.title).toList().contains(element.title)) {
        print('\x1B[33m duplicate media ${element.title}\x1B[0m');
        countDuplicateMedia++;
      }
    }
    print('\x1B[31m duplicated media : $countDuplicateMedia\x1B[0m');
  }
}
