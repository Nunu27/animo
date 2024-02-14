import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/feed_view.dart';
import 'package:flutter/material.dart';

class ExploreMangaScreen extends StatefulWidget {
  const ExploreMangaScreen({super.key});

  @override
  State<ExploreMangaScreen> createState() => _ExploreMangaScreenState();
}

class _ExploreMangaScreenState extends State<ExploreMangaScreen>
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
