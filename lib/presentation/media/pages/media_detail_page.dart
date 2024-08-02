import 'package:animo/core/theme/animo_theme.dart';
import 'package:animo/core/theme/color_schemes.g.dart';
import 'package:animo/presentation/media/providers/colorscheme_provider.dart';
import 'package:animo/presentation/media/widgets/character_list_view.dart';
import 'package:animo/presentation/media/widgets/detail_button.dart';
import 'package:animo/presentation/media/widgets/media_detail_header.dart';
import 'package:animo/presentation/media/widgets/relation_view.dart';
import 'package:animo/presentation/media/widgets/synopsis_view.dart';
import 'package:animo/presentation/media/widgets/trailer_view.dart';
import 'package:animo/presentation/shared/controllers/meta_controller.dart';
import 'package:animo/presentation/shared/views/watcher_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MediaDetailPage extends ConsumerStatefulWidget {
  final String cover;
  final int id;

  const MediaDetailPage({
    super.key,
    required this.id,
    required this.cover,
  });

  @override
  ConsumerState<MediaDetailPage> createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends ConsumerState<MediaDetailPage> {
  final _scrollController = ScrollController();

  bool headerVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateVisibility);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateVisibility() {
    final newHeaderVisible = _scrollController.offset < 300 - kToolbarHeight;

    if (newHeaderVisible == headerVisible) {
      return;
    }

    setState(() {
      headerVisible = newHeaderVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = ref.watch(getMediaProvider(widget.id)).valueOrNull;
    final colorScheme =
        ref.watch(colorSchemeProvider(widget.cover)).valueOrNull;

    return Theme(
      data: AnimoTheme(colorScheme: colorScheme ?? darkColorScheme).build(),
      child: Scaffold(
        appBar:
            media == null ? AppBar(leading: const AutoLeadingButton()) : null,
        floatingActionButton: media == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () {},
                label: Row(
                  children: [
                    const Icon(Icons.import_contacts),
                    AnimatedSize(
                      duration: Durations.short4,
                      child: headerVisible
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text('Start'),
                            ),
                    )
                  ],
                ),
              ),
        extendBodyBehindAppBar: true,
        body: WatcherView(
          provider: getMediaProvider(widget.id),
          onData: (media) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: const AutoLeadingButton(),
                  expandedHeight: 300,
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      Expanded(
                        child: AnimatedOpacity(
                          opacity: headerVisible ? 0 : 1,
                          duration: Durations.short2,
                          child: Text(media.title),
                        ),
                      ),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: MediaDetailHeader(media: media),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12)
                              .copyWith(bottom: 12),
                          child: Row(
                            children: [
                              DetailButton(
                                icon: Icons.favorite_outline,
                                text: 'Favorite',
                                onPressed: () {},
                              ),
                              DetailButton(
                                icon: Icons.share,
                                text: 'Share',
                                onPressed: () {},
                              ),
                              DetailButton(
                                icon: Icons.download_outlined,
                                text: 'Download',
                                onPressed: () {},
                              ),
                              DetailButton(
                                icon: Icons.more_horiz,
                                text: 'More',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        SynopsisView(
                          synopsis: media.description ?? 'Not available',
                        ),
                        TrailerView(trailer: media.trailer),
                        CharacterListView(characters: media.characters),
                        RelationView(relations: media.relations)
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
