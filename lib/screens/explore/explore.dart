import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/explore_anime_screen.dart';
import 'package:animo/screens/explore/explore_manga_screen.dart';
import 'package:animo/screens/explore/explore_novel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Explore extends ConsumerStatefulWidget {
  const Explore({super.key});

  @override
  ConsumerState<Explore> createState() => _ExploreState();
}

class _ExploreState extends ConsumerState<Explore>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'Anime'),
            Tab(text: 'Manga'),
            Tab(text: 'Novel'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              MediaType mediaType;
              if (_tabController.index == 0) {
                mediaType = MediaType.anime;
              } else if (_tabController.index == 1) {
                mediaType = MediaType.manga;
              } else {
                mediaType = MediaType.novel;
              }
              context.goNamed('explore-search', extra: mediaType);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Update library'),
                ),
                const PopupMenuItem(
                  child: Text('Update category'),
                ),
              ];
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ExploreAnimeScreen(),
          ExploreMangaScreen(),
          ExploreNovelScreen(),
        ],
      ),
    );
  }
}
