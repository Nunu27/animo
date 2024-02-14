import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/custom_bottom_modal_sheet.dart';
import 'package:animo/widgets/custom_input_form.dart';
import 'package:animo/widgets/filter_modal.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ChapterListView extends ConsumerStatefulWidget {
  const ChapterListView({
    super.key,
    this.total,
    this.chapterList,
    required this.parentSlug,
    this.langList,
    required this.mediaType,
    this.options,
    this.isModal = false,
    this.onTap,
    this.filter,
  });

  final int? total;
  final List<MediaContent>? chapterList;
  final String parentSlug;
  final Function(Map<String, dynamic>)? filter;
  final Map<String, dynamic>? options;
  final bool isModal;
  final List<String>? langList;
  final MediaType mediaType;
  final Function(int)? onTap;

  @override
  ConsumerState<ChapterListView> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends ConsumerState<ChapterListView> {
  late final TextEditingController _searchController;
  int currentPage = 1;
  List<MediaContent>? searchResultList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  String _handleTitle(MediaContent chapter) {
    List<String> info = [];

    if (chapter.number != null) {
      info.add('Ch. ${chapter.number}');
    }
    if (chapter.parentNumber != null) {
      info.add('Vol. ${chapter.parentNumber}');
    }

    final String text = info.join(' ');

    info.clear();
    if (text.isNotEmpty) {
      info.add(text);
    }

    if (chapter.title != null) {
      info.add(chapter.title!);
    }

    return info.isEmpty ? 'Oneshot' : info.join(': ');
  }

  String _getDate(DateTime? time) {
    if (time != null) return time.toString().substring(0, 10);
    return DateTime.now().toString().substring(0, 10);
  }

  String _handleSubtitle(DateTime? time, String? group) {
    if (group != null) return '${_getDate(time)} • $group';
    return _getDate(time);
  }

  void _handleOnTap(MediaContent mediaContent) {
    if (widget.onTap != null) {
      widget.onTap!(mediaContent.index!);
      context.pop();
    } else if (widget.isModal && widget.mediaType == MediaType.manga) {
      context.pushReplacementNamed(
        'chapter',
        pathParameters: {
          'slug': widget.parentSlug,
          'ch': mediaContent.slug,
        },
      );
    } else if (widget.mediaType == MediaType.manga) {
      context.pushNamed(
        'chapter',
        pathParameters: {
          'slug': widget.parentSlug,
          'ch': mediaContent.slug,
        },
      );
    } else if (widget.mediaType == MediaType.anime) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.all(14),
      sliver: MultiSliver(
        children: [
          SliverPinnedHeader(
            child: Column(
              children: [
                Row(
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
                        onSubmitted: (value) {
                          searchResultList = null;
                          if (widget.filter == null) {
                            setState(
                              () {
                                if (value != null && value.isNotEmpty) {
                                  // search result
                                  searchResultList = widget.chapterList!
                                      .where((chapter) =>
                                          ((chapter.number?.contains(value) ??
                                                  false) ||
                                              (chapter.parentNumber
                                                      ?.contains(value) ??
                                                  false)))
                                      .toList();
                                }
                              },
                            );
                          } else if (widget.options != null &&
                              widget.filter != null) {
                            widget.options!['query'] = value;
                            widget.filter!(widget.options!);
                          }
                        },
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                onPressed: () {
                                  searchResultList = null;
                                  setState(() {
                                    _searchController.text = '';
                                  });
                                },
                                icon: const Icon(Icons.close),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
              ],
            ),
          ),
          SliverClip(
            child: MultiSliver(
              children: [
                if (!widget.isModal)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.langList!.length} Languages are available',
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
                widget.chapterList == null
                    ? const Expanded(
                        child: Loader(),
                      )
                    : SliverList.builder(
                        itemCount: searchResultList == null
                            ? widget.chapterList!.length
                            : searchResultList!.length,
                        itemBuilder: (context, index) {
                          final MediaContent chapter =
                              widget.chapterList![index];
                          return ListTile(
                            onTap: () {
                              _handleOnTap(chapter);
                            },
                            title: Text(
                              _handleTitle(chapter),
                              style: theme.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              _handleSubtitle(
                                chapter.updatedAt,
                                chapter.group,
                              ),
                              style: theme.textTheme.bodySmall,
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.download_for_offline_outlined,
                                size: 24,
                              ),
                            ),
                            leading: chapter.lang == null
                                ? null
                                : Flag.fromString(
                                    getCountryCode(chapter.lang!),
                                    height: 24,
                                    width: 24,
                                  ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                          );
                        },
                      )
              ],
            ),
          ),
        ],
      ),
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
