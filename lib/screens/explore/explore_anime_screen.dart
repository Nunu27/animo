import 'package:animo/services/media_sources/anime/anime.dart';
import 'package:animo/widgets/cover_card.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreAnimeScreen extends ConsumerStatefulWidget {
  const ExploreAnimeScreen({super.key});

  @override
  ConsumerState<ExploreAnimeScreen> createState() => _ExploreMangaScrennState();
}

class _ExploreMangaScrennState extends ConsumerState<ExploreAnimeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return FutureBuilder(
      future: ref.read(animeProvider).filter({'sort': 'rating'}),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anime Trending',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 224,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return CoverCard(
                        media: snapshot.data!.data[index],
                        width: 120,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorView(
            message: snapshot.error.toString(),
            onRetry: () {},
          );
        } else {
          return const Loader();
        }
      },
    );
  }
}
