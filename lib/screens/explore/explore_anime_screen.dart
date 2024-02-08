import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/explore_media_future.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreAnimeScreen extends ConsumerStatefulWidget {
  const ExploreAnimeScreen({super.key});

  @override
  ConsumerState<ExploreAnimeScreen> createState() => _ExploreMangaScrennState();
}

class _ExploreMangaScrennState extends ConsumerState<ExploreAnimeScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, String>> options = [
    {'score': 'Highest score'},
    {'rating': 'Highest rating'},
    {'most_watched': 'Most watched'},
    {'recently_added': 'Recently added'},
    {'recently_updated': 'Recently updated'},
    {'released_date': 'Newest'},
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ExploreMediaFuture(
      mediaType: MediaType.anime,
      options: options,
    );
  }
}
