import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/feed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExploreMangaScreen extends ConsumerStatefulWidget {
  const ExploreMangaScreen({super.key});

  @override
  ConsumerState<ExploreMangaScreen> createState() => _ExploreMangaScreenState();
}

class _ExploreMangaScreenState extends ConsumerState<ExploreMangaScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const FeedView(
      mediaType: MediaType.manga,
    );
  }
}
