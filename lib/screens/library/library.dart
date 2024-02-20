import 'package:animo/widgets/not_login_view.dart';
import 'package:bot_toast/bot_toast.dart';
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
              onPressed: () {
                BotToast.showText(
                  text: 'this feature is not yet implemented',
                );
              },
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text('Update library'),
                    onTap: () {
                      BotToast.showText(
                        text: 'this feature is not yet implemented',
                      );
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Update category'),
                    onTap: () {
                      BotToast.showText(
                        text: 'this feature is not yet implemented',
                      );
                    },
                  ),
                ];
              },
            )
          ],
        ),
        body: const TabBarView(
          children: [
            NotLoginView(),
            NotLoginView(),
            NotLoginView(),
            // LibraryMangaScreen(),
            // LibraryMangaScreen(),
            // LibraryMangaScreen(),
          ],
        ),
      ),
    );
  }
}
