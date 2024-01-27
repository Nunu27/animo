import 'package:animo/services/media_source/manga.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryMangaScreen extends ConsumerWidget {
  const LibraryMangaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(mangaProvider).filter(sort: 'rating'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  children: [
                    ...snapshot.data!.map(
                      (e) => CoverCardCompact(media: e),
                    )
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Loader();
        }
      },
    );
  }
}
