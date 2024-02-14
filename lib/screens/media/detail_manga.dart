import 'package:animo/models/base_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/chapter_list_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:animo/widgets/character_list_view.dart';
import 'package:animo/widgets/cover.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/genre_list_view.dart';
import 'package:animo/widgets/header_detail_screen.dart';
import 'package:animo/widgets/loader.dart';
import 'package:animo/widgets/relation_view.dart';
import 'package:animo/widgets/synopsis_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DetailManga extends ConsumerStatefulWidget {
  final MediaType type;
  final String slug;

  const DetailManga({super.key, required this.type, required this.slug});

  @override
  ConsumerState<DetailManga> createState() => _DetailMangaState();
}

class _DetailMangaState extends ConsumerState<DetailManga> {
  late final TextEditingController _searchController;
  late final RefreshController _refreshController;
  late final mediaProvider = getMediaProvider(
    type: widget.type,
    slug: widget.slug,
  );
  final double _sliverAppbarHeight = 225;
  bool _isInLibrary = true;
  bool _isDownloaded = false;
  int currentPage = 1;
  int? totalChapter;
  List<MediaContent>? chapterList = [];
  Map<String, dynamic> options = {};

  @override
  void initState() {
    _searchController = TextEditingController();
    _refreshController = RefreshController(initialRefresh: true);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _fetchContents(Media media) async {
    try {
      final data = await ref.read(mediaRepositoryProvider).getMediaContents(
            media.type,
            media.getIdentifier(),
            page: currentPage,
            options: options,
          );

      totalChapter ??= data.total;
      if (currentPage == 1) {
        chapterList = data.data;
      } else {
        chapterList!.addAll(data.data);
      }

      if (_refreshController.isLoading) {
        if (data.data.isNotEmpty) {
          _refreshController.loadComplete();
        } else {
          _refreshController.loadNoData();
        }
      } else if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
    } catch (error) {
      if (_refreshController.isLoading) {
        _refreshController.loadFailed();
      } else if (_refreshController.isRefresh) {
        _refreshController.refreshFailed();
      }
    }
    setState(() {});
  }

  void _onLoading(Media media) {
    currentPage++;
    _fetchContents(media);
  }

  void _onRefresh(Media media) async {
    setState(() {
      chapterList!.clear();
    });
    totalChapter = null;
    currentPage = 1;
    _fetchContents(media);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return ref.watch(mediaProvider).when(
      data: (media) {
        return Scaffold(
          floatingActionButton: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Read'),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: theme.colorScheme.background,
          body: SmartRefresher(
            header: const WaterDropMaterialHeader(),
            footer: const ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: () {
              _onRefresh(media);
            },
            onLoading: () {
              _onLoading(media);
            },
            child: CustomScrollView(
              slivers: [
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final bool isCollapse = constraints.scrollOffset != 0;
                    return SliverAppBar(
                      expandedHeight: _sliverAppbarHeight,
                      title: isCollapse ? Text(media.title) : null,
                      pinned: true,
                      backgroundColor: isCollapse
                          ? theme.appBarTheme.backgroundColor
                          : Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        expandedTitleScale: 1,
                        background: HeaderDetailScreen(
                          height: _sliverAppbarHeight,
                          url: media.cover!,
                          child: SizedBox(
                            height: 160,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Cover(
                                      imageUrl: media.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  SizedBox(
                                    width: size.width - 158,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          media.title,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleLarge,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          media.format.text,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleSmall,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              '${media.rating ?? 0}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              media.status.icon,
                                              color: theme
                                                  .colorScheme.onBackground,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              '${media.status.text} •  ${media.year}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: theme.textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _isInLibrary = !_isInLibrary;
                            });
                          },
                          style: _isInLibrary
                              ? theme.textButtonTheme.style!.copyWith(
                                  foregroundColor: MaterialStatePropertyAll(
                                    theme.colorScheme.primary,
                                  ),
                                )
                              : null,
                          icon: _isInLibrary
                              ? const Icon(Icons.bookmark)
                              : const Icon(Icons.bookmark_outline),
                          label: const Text('Library')),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _isDownloaded = !_isDownloaded;
                          });
                        },
                        style: _isDownloaded
                            ? theme.textButtonTheme.style!.copyWith(
                                foregroundColor: MaterialStatePropertyAll(
                                  theme.colorScheme.primary,
                                ),
                              )
                            : null,
                        icon: _isDownloaded
                            ? const Icon(Icons.download_done)
                            : const Icon(Icons.download_outlined),
                        label: const Text('Download'),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  sliver: MultiSliver(
                    children: [
                      SynopsisView(text: media.description),
                      const SizedBox(
                        height: 14,
                      ),
                      CharacterListView(characters: media.characters),
                      const SizedBox(
                        height: 14,
                      ),
                      RelationView(data: media.relations),
                      const SizedBox(
                        height: 14,
                      ),
                      GenreListView(
                        genres: media.genres.map((e) => e.text).toList(),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
                ChapterListView(
                  total: totalChapter,
                  mediaType: MediaType.manga,
                  parentSlug: media.slug,
                  chapterList: chapterList,
                  langList: media.langList,
                  options: options,
                  filter: (newOptions) {
                    options = newOptions;
                    _onRefresh(media);
                  },
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return ErrorView(
          message: getError(error).message,
          onRetry: () => ref.invalidate(
            getMediaProvider(type: widget.type, slug: widget.slug),
          ),
        );
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
