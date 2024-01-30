import 'package:animo/models/media/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:animo/widgets/custom_input_form.dart';
import 'package:animo/widgets/header_detail_screen.dart';
import 'package:animo/widgets/synopsis_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailManga extends StatefulWidget {
  const DetailManga({super.key, required this.media});

  final MediaBasic media;

  @override
  State<DetailManga> createState() => _DetailMangaState();
}

class _DetailMangaState extends State<DetailManga> {
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
        thickness: 6,
        child: CustomScrollView(
          slivers: [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                final bool expanded = constraints.scrollOffset >
                    _sliverAppbarHeight - kToolbarHeight;
                return SliverAppBar(
                  expandedHeight: _sliverAppbarHeight,
                  title: expanded ? Text(widget.media.title) : null,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    expandedTitleScale: 1,
                    background: HeaderDetailScreen(
                      height: _sliverAppbarHeight,
                      url: widget.media.cover!,
                      child: SizedBox(
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Cover(
                                  imageUrl: widget.media.cover!,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              SizedBox(
                                width: size.width - 158,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.media.title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Manga',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleSmall,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '8.8/10.0 • 2023',
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
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              sliver: SliverToBoxAdapter(
                child: SynopsisView(
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 138,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 64,
                              width: 64,
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  widget.media.cover!,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Jojo Bizzare Adventure',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Main',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: OutlinedButton(
                          style: theme.outlinedButtonTheme.style!.copyWith(
                            padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 14),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Genre',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
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
                                '100 Total chapters found',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomInputForm(
                            hintText: 'Goto',
                            hintTextStyle: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textStyle: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            controller: _searchController,
                            onChanged: (value) {
                              setState(
                                () {
                                  if (value != null) {
                                    searchResultList = chapterList
                                        .where((chapter) => chapter
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '32 Languages are available',
                          style: theme.textTheme.bodyMedium,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  onTap: () {},
                  title: Text(
                    searchResultList.isEmpty
                        ? chapterList[index]
                        : searchResultList[index],
                  ),
                ),
                childCount: searchResultList.isEmpty
                    ? chapterList.length
                    : searchResultList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
