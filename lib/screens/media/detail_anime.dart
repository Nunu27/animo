import 'package:animo/models/base_data.dart';
import 'package:animo/models/content/video_content.dart';
import 'package:animo/models/content/video_data.dart';
import 'package:animo/models/media/media.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/media/media_content.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/providers/library_manager_provider.dart';
import 'package:animo/providers/user_provider.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/chapter_list/episode_list_anime.dart';
import 'package:animo/widgets/character_list_view.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/genre_list_view.dart';
import 'package:animo/widgets/loader.dart';
import 'package:animo/widgets/relation_view.dart';
import 'package:animo/widgets/synopsis_view.dart';
import 'package:animo/widgets/trailer_view.dart';
import 'package:animo/widgets/video_player_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animo/repositories/media_repository.dart';

class DetailAnime extends ConsumerStatefulWidget {
  final MediaType type;
  final String slug;

  const DetailAnime({super.key, required this.type, required this.slug});

  @override
  ConsumerState<DetailAnime> createState() => _DetailAnimeState();
}

class _DetailAnimeState extends ConsumerState<DetailAnime> {
  late final ScrollController _scrollController;
  GlobalKey titleKey = GlobalKey();
  MediaContent? _videoMediaContent;
  VideoContent? _videoContent;
  List<MediaContent>? _episodeList;
  VideoData? _videoData;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _toggleLibrary(MediaBasic media) {
    final manager = ref.read(libraryManagerProvider);

    if (ref.read(isInLibraryProvider(slug: widget.slug, type: widget.type))) {
      manager.remove([media]);
    } else {
      manager.add([media]);
    }
  }

  Future<void> _fetchChapterList(Media media) async {
    final data = await ref.read(mediaRepositoryProvider).getMediaContents(
          media.type,
          media.getIdentifier(),
        );

    if (mounted) {
      setState(() {
        _episodeList = data.data;
      });
    }
    _fetchVideoContent(media);
  }

  void _fetchVideoContent(Media media) async {
    if (mounted) {
      setState(() {
        _videoData = null;
      });
    }
    if (_videoMediaContent != null) {
      BaseData baseData = BaseData(
        slug: _videoMediaContent!.slug,
        type: MediaType.anime,
        parentSlug: media.slug,
      );
      final futureContentData =
          ref.read(mediaRepositoryProvider).getContent(baseData);

      final data = await futureContentData;

      _videoContent = data.data;

      if (_videoContent != null) {
        final futureVideoContent = ref.read(
            getSourceProvider(videoServer: _videoContent!.sub.first).future);

        _videoData = await futureVideoContent;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final user = ref.watch(userStateProvider);
    final inLibrary = ref.watch(
      isInLibraryProvider(slug: widget.slug, type: widget.type),
    );

    return ref
        .watch(getMediaProvider(type: widget.type, slug: widget.slug))
        .when(
      data: (media) {
        if (_episodeList == null) {
          _fetchChapterList(media);
        }
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: RefreshIndicator(
            onRefresh: () => _fetchChapterList(media),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  title: Text(media.title),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: VideoPlayerView(
                    videoData: _videoData,
                    thumbnail: media.trailer?.thumbnail ?? media.cover,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    key: titleKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          media.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text(
                              'Anime',
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text('•'),
                            const SizedBox(
                              width: 6,
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
                              width: 6,
                            ),
                            const Text('•'),
                            const SizedBox(
                              width: 6,
                            ),
                            Row(
                              children: [
                                Icon(
                                  media.status.icon,
                                  color: theme.colorScheme.onBackground,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  media.status.text,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text('•'),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              media.year.toString(),
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        )
                      ],
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
                                  : () => _toggleLibrary(media.toMediaBasic()),
                              style: inLibrary
                                  ? theme.textButtonTheme.style!.copyWith(
                                      foregroundColor: MaterialStatePropertyAll(
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
                EpisodeListAnime(
                  episodeList: _episodeList ?? [],
                  parentSlug: media.slug,
                  onTap: (value) {
                    _scrollController.animateTo(0,
                        duration: Durations.long3, curve: Curves.easeInOut);
                    _videoMediaContent = value;
                    _fetchVideoContent(media);
                  },
                )
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
          ),
        );
      },
      loading: () {
        return Scaffold(
          appBar: AppBar(),
          body: const Loader(),
        );
      },
    );
  }
}
