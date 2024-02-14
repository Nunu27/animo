import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/feed_view.dart';
import 'package:flutter/material.dart';

class ExploreNovelScreen extends StatefulWidget {
  const ExploreNovelScreen({super.key});

  @override
  State<ExploreNovelScreen> createState() => _ExploreNovelScreenState();
}

class _ExploreNovelScreenState extends State<ExploreNovelScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const FeedView(
      mediaType: MediaType.novel,
    );
  }
}
