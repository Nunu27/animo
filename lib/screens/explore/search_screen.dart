import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/widgets/cover_card_compact_gridview.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/filter_modal.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  late MediaType selectedMediaType;
  Map<String, dynamic> options = {};

  @override
  void initState() {
    super.initState();
    selectedMediaType = widget.mediaType;
    _searchController = TextEditingController();
  }

  Future<PaginatedData<MediaBasic>>? _handleSearchType(MediaType mediaType) {
    final mediaRepository = ref.read(mediaRepositoryProvider);
    options['query'] =
        _searchController.text.isEmpty ? null : _searchController.text;

    return mediaRepository.filter(mediaType, options);
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
              child: FutureBuilder(
                future: _handleSearchType(selectedMediaType),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final searchResult = snapshot.data!.data;
                    return searchResult.isEmpty
                        ? ErrorView(
                            message:
                                "${selectedMediaType.name} '${_searchController.text}' not found",
                          )
                        : CoverCardCompactGridView(
                            data: searchResult,
                            column: 3,
                          );
                  } else if (snapshot.hasError) {
                    return ErrorView(message: snapshot.error.toString());
                  } else {
                    return const Loader();
                  }
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
        FilterModal(options: options, mediaType: selectedMediaType),
      ],
    ).showModal();

    if (data != null) {
      setState(() {
        options = data;
      });
    }
  }
}
