import 'package:animo/models/media/media_content.dart';
import 'package:animo/widgets/custom_input_form.dart';
import 'package:animo/widgets/loading_gridtile.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EpisodeListAnime extends ConsumerStatefulWidget {
  const EpisodeListAnime({
    super.key,
    this.total,
    required this.episodeList,
    required this.parentSlug,
    required this.onTap,
  });

  final int? total;
  final List<MediaContent> episodeList;
  final String parentSlug;
  final ValueChanged<MediaContent> onTap;

  @override
  ConsumerState<EpisodeListAnime> createState() => _ChapterListViewState();
}

class _ChapterListViewState extends ConsumerState<EpisodeListAnime> {
  late final TextEditingController _searchController;
  late final PageController _pageController;
  List<List<MediaContent>> subEpisodeList = [];
  bool isSearch = false;
  int activePage = 0;
  int episodeFound = 0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _pageController.dispose();
  }

  String _handleTitle(MediaContent chapter) {
    String title;

    if (chapter.number != null) {
      title = 'E${chapter.number}';
    } else {
      title = '?';
    }

    return title;
  }

  void _updateSubEpisodeList(List<MediaContent> episodes) {
    subEpisodeList = episodes.slices(15).toList();
  }

  int _getEpisodeFound() {
    int length = subEpisodeList.flatMap((t) => t).length;
    return length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (widget.episodeList.isNotEmpty &&
        !isSearch &&
        widget.episodeList.length != episodeFound) {
      _updateSubEpisodeList(widget.episodeList);
      episodeFound = _getEpisodeFound();
    }
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
                            '$episodeFound episodes found',
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
                          isSearch = true;

                          setState(
                            () {
                              if (value != null && value.isNotEmpty) {
                                _updateSubEpisodeList(widget.episodeList
                                    .where((chapter) =>
                                        chapter.number?.contains(value) ??
                                        false)
                                    .toList());
                                episodeFound = _getEpisodeFound();
                              }
                            },
                          );
                        },
                        suffixIcon: _searchController.text.isEmpty
                            ? const Icon(Icons.search)
                            : IconButton(
                                onPressed: () {
                                  isSearch = false;
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
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ),
        SliverClip(
          child: SliverPadding(
            padding: const EdgeInsets.all(14),
            sliver: widget.episodeList.isEmpty
                ? const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 240,
                      child: LoadingGridTile(
                        column: 5,
                        itemCount: 15,
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 8,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: subEpisodeList.length,
                            itemBuilder: (context, index) {
                              return ChoiceChip(
                                showCheckmark: false,
                                selected: index == activePage,
                                onSelected: (value) {
                                  _pageController.animateToPage(index,
                                      curve: Curves.easeInOut,
                                      duration: Durations.long3);
                                },
                                label: Text(
                                  '${subEpisodeList[index].first.number} - ${subEpisodeList[index].last.number}',
                                  style: theme.textTheme.titleSmall,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          height: 240,
                          child: PageView.builder(
                            pageSnapping: true,
                            controller: _pageController,
                            onPageChanged: (value) {
                              setState(() {
                                activePage = value;
                              });
                            },
                            itemCount: subEpisodeList.length,
                            itemBuilder: (context, indexPage) {
                              return GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                crossAxisCount: 5,
                                children: subEpisodeList[indexPage]
                                    .mapWithIndex(
                                        (MediaContent chapter, int indexGrid) {
                                  return GridTile(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () => widget.onTap(
                                            widget.episodeList[
                                                indexPage * indexGrid]),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: theme
                                                .colorScheme.onBackground
                                                .withOpacity(0.05),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              _handleTitle(chapter),
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
