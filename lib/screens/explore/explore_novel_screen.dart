import 'package:animo/models/base_data.dart';
import 'package:animo/screens/explore/explore_media_future.dart';
import 'package:flutter/material.dart';

class ExploreNovelScreen extends StatefulWidget {
  const ExploreNovelScreen({super.key});

  @override
  State<ExploreNovelScreen> createState() => _ExploreNovelScreenState();
}

class _ExploreNovelScreenState extends State<ExploreNovelScreen>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, String>> options = [
    {'srel': 'Most popular'},
    {'sfrel': 'Highest rating'},
    {'srank': 'Most follows'},
    {'srate': 'Newest'},
    {'sreview': 'Most views'},
    {'sdate': 'Last updated'},
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExploreMediaFuture(
      mediaType: MediaType.novel,
      options: options,
    );
  }
}
