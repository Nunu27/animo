import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/widgets/custom_input_form.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ChapterListView extends ConsumerStatefulWidget {
  const ChapterListView({
    super.key,
    this.total,
    required this.chapterList,
    required this.parentSlug,
    this.langList,
    required this.mediaType,
    this.isModal = false,
    this.onTap,
  });

  final int? total;
  final List<MediaContent> chapterList;
  final String parentSlug;
  final bool isModal;
  final List<String>? langList;
  final MediaType mediaType;
  final Function(int)? onTap;

  @override
  ConsumerState<ChapterListView> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends ConsumerState<ChapterListView> {
  late final TextEditingController _searchController;
  List<MediaContent> searchResultList = [];

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
    if (chapter.title == null || chapter.title!.isEmpty) {
      return 'Chapter ${chapter.number}';
    } else {
      return 'Ch. ${chapter.number}: ${chapter.title}';
    }
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
                            '${searchResultList.isEmpty ? widget.total ?? '?' : searchResultList.length} chapters found',
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
                        onChanged: (value) {
                          searchResultList.clear();
                          setState(
                            () {
                              if (value != null && value.isNotEmpty) {
                                // search result
                                searchResultList = widget.chapterList
                                    .where((chapter) =>
                                        chapter.number!.contains(value))
                                    .toList();
                              }
                            },
                          );
                        },
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    _searchController.text = '';
                                    searchResultList.clear();
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
                if (widget.langList != null &&
                    widget.mediaType != MediaType.anime)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.langList!.length} Languages are available',
                        style: theme.textTheme.bodyMedium,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list),
                      ),
                    ],
                  ),
                SliverList.builder(
                  itemCount: searchResultList.isEmpty
                      ? widget.chapterList.length
                      : searchResultList.length,
                  itemBuilder: (context, index) {
                    final MediaContent currentChapter =
                        widget.chapterList[index];
                    return ListTile(
                      onTap: () {
                        _handleOnTap(currentChapter);
                      },
                      title: Text(
                        searchResultList.isEmpty
                            ? _handleTitle(currentChapter)
                            : _handleTitle(searchResultList[index]),
                        style: theme.textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        _handleSubtitle(
                          currentChapter.updatedAt,
                          currentChapter.group,
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
                      leading: currentChapter.lang == null
                          ? null
                          : Flag.fromString(
                              currentChapter.lang!,
                              height: 24,
                              width: 24,
                            ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
}
