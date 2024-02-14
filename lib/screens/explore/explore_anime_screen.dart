import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/feed_view.dart';
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

    return const FeedView(
      mediaType: MediaType.anime,
    );
  }
}
