import 'package:animo/services/media_sources/manga/manga.dart';
import 'package:animo/widgets/cover_card_compact_gridview.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CoverCardCompactGridView(data: snapshot.data!.data),
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
