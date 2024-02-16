import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/chapter_list/chapter_tile.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/custom_input_form.dart';
import 'package:animo/widgets/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ChapterListView extends ConsumerStatefulWidget {
  const ChapterListView({
    super.key,
    this.total,
    required this.parentSlug,
    required this.type,
    this.chapterList,
    this.langList,
    this.options,
    this.onTap,
    this.filter,
    this.isModal = false,
  });

  final int? total;
  final String parentSlug;
  final MediaType type;
  final List<MediaContent>? chapterList;
  final List<String>? langList;
  final Map<String, dynamic>? options;
  final Function(int)? onTap;
  final Function(Map<String, dynamic>)? filter;
  final bool isModal;

  @override
  ConsumerState<ChapterListView> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends ConsumerState<ChapterListView> {
  final TextEditingController _searchController = TextEditingController();
  List<MediaContent>? searchResultList;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String? value) {
    searchResultList = null;
    if (widget.filter == null) {
      setState(
        () {
          if (value != null && value.isNotEmpty) {
            searchResultList = widget.chapterList!
                .where((chapter) => chapter.number?.contains(value) ?? false)
                .toList();
          }
        },
      );
    } else if (widget.options != null && widget.filter != null) {
      widget.options!['query'] = value;
      widget.filter!(widget.options!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiSliver(
      children: [
        SliverPinnedHeader(
          child: Column(
            children: [
              Container(
                color: theme.colorScheme.background,
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            '${searchResultList == null ? widget.total ?? '?' : searchResultList!.length} chapters found',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomInputForm(
                        keyboardType: TextInputType.number,
                        hintText: 'Goto',
                        hintTextStyle: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textStyle: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        controller: _searchController,
                        onSubmitted: _search,
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _search(null);
                                },
                                icon: const Icon(Icons.close),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ),
        if (widget.isModal)
          SliverList.builder(
            itemCount: searchResultList?.length ?? widget.chapterList!.length,
            itemBuilder: (context, index) => ChapterTile(
              onTap: widget.onTap,
              parentSlug: widget.parentSlug,
              type: widget.type,
              chapter: (searchResultList ?? widget.chapterList!)[index],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.langList?.length ?? 1} Languages are available',
                  style: theme.textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () {
                    _showFilterModal(context, theme);
                  },
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _showFilterModal(BuildContext context, ThemeData theme) async {
    final Map<String, dynamic>? data = await CustomBottomModalSheet(
      context: context,
      maxChildExpand: 1,
      children: [
        FilterModal(
            options: widget.options ?? {},
            filters: getProviderInfo(MediaType.manga).contentFilters!),
      ],
    ).showModal();

    if (data != null && widget.filter != null) widget.filter!(data);
  }
}
