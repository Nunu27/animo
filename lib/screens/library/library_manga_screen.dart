import 'package:animo/services/media_sources/manga/manga.dart';
import 'package:animo/widgets/cover_card_compact.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LibraryMangaScreen extends ConsumerStatefulWidget {
  const LibraryMangaScreen({super.key});

  @override
  ConsumerState<LibraryMangaScreen> createState() => _LibraryMangaScreenState();
}

class _LibraryMangaScreenState extends ConsumerState<LibraryMangaScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: ref.read(mangaProvider).filter({'sort': 'rating'}),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 225 / 350,
                  children: [
                    ...snapshot.data!.data.map(
                      (e) => CoverCardCompact(
                        media: e,
                      ),
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
