import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/providers/library_manager_provider.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/chapter_list/chapter_list_view.dart';
import 'package:animo/widgets/chapter_list/chapter_tile.dart';
import 'package:animo/widgets/character_list_view.dart';
import 'package:animo/widgets/cover.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/genre_list_view.dart';
import 'package:animo/widgets/header_detail_screen.dart';
import 'package:animo/widgets/loader.dart';
import 'package:animo/widgets/loading_listtile.dart';
import 'package:animo/widgets/paginated_view.dart';
import 'package:animo/widgets/relation_view.dart';
import 'package:animo/widgets/synopsis_view.dart';
import 'package:animo/widgets/trailer_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String slug;
  final MediaType type;
  final double appBarHeight = 225;

  const DetailScreen({super.key, required this.slug, required this.type});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  final PagingController<int, MediaContent> _pagingController =
      PagingController(firstPageKey: 1);
  final double appBarHeight = 225;

  int? total;
  MediaContent? firstChapter;
  List<MediaContent>? chapters;
  Map<String, dynamic> options = {};

  void _retry() {
    ref.invalidate(getMediaProvider(slug: widget.slug, type: widget.type));
  }

  void _toggleLibrary(MediaBasic media) {
    final manager = ref.read(libraryManagerProvider);

    if (ref.read(isInLibraryProvider(slug: widget.slug, type: widget.type))) {
      manager.remove([media]);
    } else {
      manager.add([media]);
    }
  }

  Future<PaginatedData<MediaContent>> _fetch(
    Media media,
    int page,
  ) async {
    final providerInfo = getProviderInfo(widget.type);
    if (page == 1 && total != null && chapters == null) {
      setState(() {
        total = null;
      });
    }

    if (chapters != null) {
      final String? query = options['query'];
      if (query == null) {
        return PaginatedData(data: chapters!);
      } else {
        return PaginatedData(
          data: chapters!
              .where((chapter) => chapter.number?.contains(query) ?? false)
              .toList(),
        );
      }
    }

    try {
      final result = await ref.read(mediaRepositoryProvider).getMediaContents(
            media.type,
            media.getIdentifier(),
            page: page,
            options: options,
          );

      if (total == null) {
        if (providerInfo.contentFilters == null) chapters = result.data;

        if (options['query'] == null) {
          setState(() {
            total = result.total;
          });
        } else if (!result.haveMore) {
          setState(() {
            total =
                (_pagingController.itemList?.length ?? 0) + result.data.length;
          });
        }
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  void _readChapter(MediaContent chapter) async {
    final type = widget.type;

    context.pushNamed(
      'read',
      pathParameters: {
        'slug': widget.slug,
        'type': type.name,
      },
      extra: {
        'syncData': (await ref
                .read(getMediaProvider(slug: widget.slug, type: type).future))
            .toSyncData(),
        'chapter': chapter,
        'chapters': chapters,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    final user = ref.watch(userStateProvider);
    final inLibrary = ref.watch(
      isInLibraryProvider(slug: widget.slug, type: widget.type),
    );

    return ref
        .watch(getMediaProvider(slug: widget.slug, type: widget.type))
        .when(
          skipLoadingOnRefresh: false,
          data: (media) {
            final chapterToRead = media.firstContent ?? firstChapter;

            return Scaffold(
              floatingActionButton: chapterToRead == null
                  ? null
                  : FilledButton.icon(
                      onPressed: () => _readChapter(chapterToRead),
                      icon: const Icon(Icons.import_contacts),
                      label: Text(chapterToRead.getSimpleTitle()),
                    ),
              extendBodyBehindAppBar: true,
              body: PaginatedView(
                pagingController: _pagingController,
                fetcher: (page) => _fetch(media, page),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: appBarHeight,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        expandedTitleScale: 1,
                        title: LayoutBuilder(
                          builder: (context, constraints) {
                            final top = constraints.biggest.height;

                            return AnimatedOpacity(
                              opacity: top >
                                      kToolbarHeight +
                                          MediaQuery.of(context).padding.top
                                  ? 0
                                  : 1,
                              duration: const Duration(milliseconds: 100),
                              child: Text(
                                media.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                        background: HeaderDetailScreen(
                          height: appBarHeight,
                          url: media.cover,
                          child: SizedBox(
                            height: 160,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
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
                                              '${media.rating ?? 'N/A'}',
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
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                  onPressed: user == null
                                      ? null
                                      : () =>
                                          _toggleLibrary(media.toMediaBasic()),
                                  style: inLibrary
                                      ? theme.textButtonTheme.style!.copyWith(
                                          foregroundColor:
                                              MaterialStatePropertyAll(
                                            theme.colorScheme.primary,
                                          ),
                                        )
                                      : null,
                                  icon: inLibrary
                                      ? const Icon(Icons.bookmark)
                                      : const Icon(Icons.bookmark_outline),
                                  label: const Text('Library')),
                              TextButton.icon(
                                onPressed: user == null
                                    ? null
                                    : () {
                                        // setState(() {
                                        //   _isDownloaded = !_isDownloaded;
                                        // });
                                      },

                                style: theme.textButtonTheme.style!.copyWith(
                                  foregroundColor: MaterialStatePropertyAll(
                                    theme.colorScheme.primary,
                                  ),
                                ),
                                // : null,
                                icon: const Icon(Icons.download_done),
                                // : const Icon(Icons.download_outlined),
                                label: const Text('Download'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  BotToast.showText(
                                    text: 'this feature is not yet implemented',
                                  );
                                },
                                icon: const Icon(Icons.share),
                                label: const Text('Share'),
                              ),
                            ],
                          ),
                          SynopsisView(text: media.description),
                          if (media.trailer != null)
                            TrailerView(trailer: media.trailer!),
                          if (media.characters != null)
                            CharacterListView(characters: media.characters!),
                          if (media.relations != null)
                            RelationView(data: media.relations!),
                          GenreListView(
                            genres: media.genres.map((e) => e.text).toList(),
                          ),
                        ],
                      ),
                    ),
                    ChapterListView(
                      total: total,
                      parentSlug: media.slug,
                      type: media.type,
                      options: options,
                      filter: (newOptions) {
                        options = newOptions;
                        _pagingController.refresh();
                      },
                    ),
                    if (_pagingController.value.status ==
                        PagingStatus.loadingFirstPage)
                      SliverList.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: LoadingListTile(),
                          );
                        },
                      ),
                    PagedSliverList(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<MediaContent>(
                        itemBuilder: (context, item, index) => ChapterTile(
                          parentSlug: media.slug,
                          type: media.type,
                          chapter: item,
                          onTap: (chapter) => _readChapter(chapter),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Scaffold(
              appBar: AppBar(),
              body: ErrorView(
                message: getError(error).message,
                onRetry: _retry,
              ),
            );
          },
          loading: () => Scaffold(
            appBar: AppBar(),
            body: const Loader(),
          ),
        );
  }
}
