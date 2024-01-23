import 'package:animo/services/media_source/anime.dart';
import 'package:animo/services/media_source/manga.dart';
import 'package:animo/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return FutureBuilder(
      future: ref.read(mangaProvider).filter(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manga Trending',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              width: 120,
                              imageUrl: snapshot.data![0].cover!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            snapshot.data![0].title,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
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
