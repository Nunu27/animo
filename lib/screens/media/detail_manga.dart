import 'package:animo/models/base_media.dart';
import 'package:animo/services/api.dart';
import 'package:animo/widgets/chapter_list_view.dart';
import 'package:animo/widgets/character_list_view.dart';
import 'package:animo/widgets/cover.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/genre_list_view.dart';
import 'package:animo/widgets/header_detail_screen.dart';
import 'package:animo/widgets/loader.dart';
import 'package:animo/widgets/synopsis_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailManga extends ConsumerStatefulWidget {
  const DetailManga({super.key, required this.baseMedia});

  final BaseMedia baseMedia;

  @override
  ConsumerState<DetailManga> createState() => _DetailMangaState();
}

class _DetailMangaState extends ConsumerState<DetailManga> {
  late final TextEditingController _searchController;
  final double _sliverAppbarHeight = 225;
  bool _isInLibrary = true;
  bool _isDownloaded = false;

  final List<String> chapterList =
      List.generate(100, (index) => 'Chapter $index');

  List<String> searchResultList = [];

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    // final searchManga = ref.read(mangaProvider).filter({'q': ''});
    // final searchAnime = ref.read(animeProvider).filter({'keyword': ''});

    return ref.watch(getMediaProvider(widget.baseMedia)).when(
      data: (media) {
        return Scaffold(
          floatingActionButton: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Read'),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: theme.colorScheme.background,
          body: Scrollbar(
            interactive: true,
            radius: const Radius.circular(40),
            thickness: 8,
            child: CustomScrollView(
              slivers: [
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final bool isCollapse = constraints.scrollOffset >
                        _sliverAppbarHeight - kToolbarHeight;
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
                                      imageUrl: media.cover!,
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
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleSmall,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${media.rating ?? 0} • ${media.year}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleSmall,
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
                        GenreListView(genres: media.genres),
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                ChapterListView(
                  chapterList: chapterList,
                  slug: media.slug,
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return ErrorView(message: error.toString());
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
