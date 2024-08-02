import 'package:animo/core/constants/constants.dart';
import 'package:animo/core/dependencies/repositories.dart';
import 'package:animo/core/mixins/filter_mixin.dart';
import 'package:animo/core/router/app_router.gr.dart';
import 'package:animo/domain/entities/media/media_basic.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/presentation/search/providers/filter_provider.dart';
import 'package:animo/presentation/search/widgets/filter_modal.dart';
import 'package:animo/presentation/shared/views/pagination/paginated_child_builder_delegate.dart';
import 'package:animo/presentation/shared/views/pagination/paginated_controller.dart';
import 'package:animo/presentation/shared/views/pagination/paginated_view.dart';
import 'package:animo/presentation/shared/widgets/cards/card_cover_compact.dart';
import 'package:animo/presentation/shared/widgets/draggable_modal_buttom_sheet.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  final MediaType mediaType;

  const SearchPage({super.key, required this.mediaType});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> with FilterMixin {
  late final TextEditingController _searchController;
  late final PaginatedController<int, MediaBasic> _pagingController;
  late MediaType _selectedMediaType;
  CancelToken? cancelToken;

  late Map<String, dynamic> options;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _pagingController = PaginatedController(firstPageKey: 1);
    _selectedMediaType = widget.mediaType;
    options = getDefaultOptions(_selectedMediaType);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<PaginatedData<MediaBasic>> _fetch(int page, CancelToken? token) async {
    final res = await ref.read(metaRepositoryProvider).filter(
      {
        ...options,
        'search':
            _searchController.text.isEmpty ? null : _searchController.text,
        'page': page,
      },
      cancelToken: token,
    );

    return res;
  }

  void _showFilterModal(BuildContext context) async {
    ref.read(filterStateProvider.notifier).setOption(Map.of(options));

    await DraggableBottomModalSheet(
      context: context,
      appbar: AppBar(
        automaticallyImplyLeading: false,
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                ref
                    .read(filterStateProvider.notifier)
                    .reset(_selectedMediaType);
              },
              style: Theme.of(context).textButtonTheme.style!.copyWith(
                    foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
              child: const Text('Reset'),
            ),
            FilledButton(
              onPressed: () {
                context.router.maybePop();
                options = ref.read(filterStateProvider);
                _pagingController.refresh();
              },
              child: const Text('Filter'),
            )
          ],
        ),
      ),
      maxChildExpand: 1,
      child: FilterModal(
        type: _selectedMediaType,
        filters: ref.read(metaRepositoryProvider).filters[_selectedMediaType]!,
      ),
    ).showModal();

    ref.invalidate(filterStateProvider);
  }

  @override
  Widget build(BuildContext context) {
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
                      _pagingController.refresh();
                    }),
            hintText: 'Search',
          ),
          onSubmitted: (value) {
            if (_pagingController.itemList != null) {
              _pagingController.refresh();
            }
            // setState(() {});
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ).copyWith(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SegmentedButton(
                    showSelectedIcon: false,
                    segments: MediaType.values
                        .map(
                          (mediaType) => ButtonSegment(
                            value: mediaType,
                            label: Text(mediaType.text),
                          ),
                        )
                        .toList(),
                    selected: <MediaType>{_selectedMediaType},
                    onSelectionChanged: (value) {
                      setState(() {
                        _selectedMediaType = value.first;
                        options = getDefaultOptions(_selectedMediaType);
                      });
                      _pagingController.refresh();
                    }),
                FilledButton.icon(
                  onPressed: () {
                    _showFilterModal(context);
                  },
                  icon: const Icon(Icons.filter_list_rounded),
                  label: const Text('Filter'),
                )
              ],
            ),
          ),
        ),
      ),
      body: PaginatedView(
        pagingController: _pagingController,
        fetchData: _fetch,
        child: PagedGridView(
          padding: const EdgeInsets.all(4),
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: Constants.coverRatio,
          ),
          pagingController: _pagingController,
          builderDelegate: PaginatedChildBuilderDelegate(
            pagingController: _pagingController,
            itemBuilder: (context, item, index) {
              return CardCoverCompact(
                media: item,
                onTap: () {
                  context.pushRoute(
                    MediaDetailRoute(id: item.id, cover: item.cover),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
