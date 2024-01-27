import 'package:animo/screens/explore/explore_anime_screen.dart';
import 'package:animo/screens/explore/explore_manga_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Explore extends ConsumerWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explore'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Anime',
              ),
              Tab(
                text: 'Manga',
              ),
              Tab(
                text: 'Novel',
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
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
        body: const TabBarView(
          children: [
            ExploreAnimeScreen(),
            ExploreMangaScrenn(),
            ExploreMangaScrenn(),
          ],
        ),
      ),
    );
  }
}
