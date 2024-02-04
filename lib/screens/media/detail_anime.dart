import 'package:animo/models/base_data.dart';
import 'package:animo/services/api.dart';
import 'package:animo/widgets/chapter_list_view.dart';
import 'package:animo/widgets/character_list_view.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/genre_list_view.dart';
import 'package:animo/widgets/header_detail_screen.dart';
import 'package:animo/widgets/loader.dart';
import 'package:animo/widgets/relation_view.dart';
import 'package:animo/widgets/synopsis_view.dart';
import 'package:animo/widgets/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailAnime extends ConsumerStatefulWidget {
  const DetailAnime({super.key, required this.baseMedia});

  final BaseData baseMedia;

  @override
  ConsumerState<DetailAnime> createState() => _DetailAnimeState();
}

class _DetailAnimeState extends ConsumerState<DetailAnime> {
  bool _isInLibrary = true;
  bool _isDownloaded = false;
  GlobalKey titleKey = GlobalKey();

  final List<String> chapterList =
      List.generate(100, (index) => 'Chapter $index');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double sliverHeight = MediaQuery.of(context).size.width / 16 * 9;

    return ref.watch(getMediaProvider(widget.baseMedia)).when(
      data: (media) {
        return Scaffold(
          floatingActionButton: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Read'),
          ),
          backgroundColor: theme.colorScheme.background,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(media.title),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: VideoPlayerView(
                  url:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                  placeholder: HeaderDetailScreen(
                    height: sliverHeight,
                    url: media.trailer?.thumbnail ?? media.cover!,
                  ),
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
                          Text(
                            media.year.toString(),
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text('•'),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            media.rating.toString(),
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SynopsisView(text: media.description),
                      const SizedBox(
                        height: 14,
                      ),
                      CharacterListView(characters: media.characters),
                      const SizedBox(
                        height: 14,
                      ),
                      RelationView(
                        relationList: media.relations?.data,
                        dataSource: media.source,
                        slug: media.slug,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      GenreListView(
                          genres: media.genres.map((e) => e.text).toList()),
                      const SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: ref
                    .read(apiServiceProvider)
                    .getMediaContents(media.toSyncData()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ChapterListView(
                      mediaType: MediaType.anime,
                      parentSlug: media.slug,
                      chapterList: snapshot.data!.data,
                      langList: media.langList,
                    );
                  } else if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: ErrorView(
                        message: snapshot.error.toString(),
                        onRetry: () {},
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Loader(),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return ErrorView(
          message: error.toString(),
        );
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
