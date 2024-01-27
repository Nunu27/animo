import 'package:animo/models/media_basic.dart';
import 'package:animo/widgets/cover.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailManga extends StatefulWidget {
  const DetailManga({super.key, required this.media});

  final MediaBasic media;

  @override
  State<DetailManga> createState() => _DetailMangaState();
}

class _DetailMangaState extends State<DetailManga> {
  late final ScrollController _scrollController;
  late bool _isSliverAppBarExpanded;
  final double _sliverAppbarHeight = 225;
  bool _isInLibrary = true;
  bool _isNotificationEnabled = false;

  @override
  void initState() {
    _isSliverAppBarExpanded = false;
    _scrollController = ScrollController();

    _scrollController.addListener(
      () {
        setState(() {
          if (_scrollController.hasClients &&
              _scrollController.offset > _sliverAppbarHeight - kToolbarHeight) {
            _isSliverAppBarExpanded = true;
          } else {
            _isSliverAppBarExpanded = false;
          }
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: _sliverAppbarHeight,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list_rounded),
              ),
            ],
            title: _isSliverAppBarExpanded ? Text(widget.media.title) : null,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1,
              background: Stack(
                children: [
                  CachedNetworkImage(
                    height: _sliverAppbarHeight - 2,
                    width: size.width,
                    imageUrl: widget.media.cover!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: _sliverAppbarHeight,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colorScheme.background.withOpacity(0.5),
                          theme.colorScheme.background,
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
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
                                    height: 6,
                                  ),
                                  Text(
                                    'Manga',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 6,
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
                      _isNotificationEnabled = !_isNotificationEnabled;
                    });
                  },
                  style: _isNotificationEnabled
                      ? theme.textButtonTheme.style!.copyWith(
                          foregroundColor: MaterialStatePropertyAll(
                            theme.colorScheme.primary,
                          ),
                        )
                      : null,
                  icon: _isNotificationEnabled
                      ? const Icon(Icons.notifications)
                      : const Icon(Icons.notifications_outlined),
                  label: const Text('Notification'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
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
                            EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Genre'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              child: Text(
                '100 Chapters',
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                onTap: () {},
                title: Text('chapter ${index + 1}'),
              ),
              childCount: 100,
            ),
          )
        ],
      ),
    );
  }
}
