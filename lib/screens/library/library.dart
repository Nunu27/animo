import 'package:animo/screens/library/library_manga_screen.dart';
import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Anime',
              ),
              Tab(
                text: 'Manga',
              ),
              Tab(
                text: 'Novel',
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
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
            LibraryMangaScreen(),
            LibraryMangaScreen(),
            LibraryMangaScreen(),
          ],
        ),
      ),
    );
  }
}
