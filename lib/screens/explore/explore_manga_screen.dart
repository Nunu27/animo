import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/explore_media_future.dart';
import 'package:flutter/material.dart';

class ExploreMangaScreen extends StatefulWidget {
  const ExploreMangaScreen({super.key});

  @override
  State<ExploreMangaScreen> createState() => _ExploreMangaScreenState();
}

class _ExploreMangaScreenState extends State<ExploreMangaScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, String>> options = [
    {'follow': 'Most popular'},
    {'rating': 'Highest rating'},
    {'user_follow_count': 'Most follows'},
    {'created_at': 'Newest'},
    {'view': 'Most views'},
    {'uploaded': 'Last updated'},
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExploreMediaFuture(
      mediaType: MediaType.manga,
      options: options,
    );
  }
}
