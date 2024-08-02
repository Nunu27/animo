import 'package:animo/core/router/app_router.gr.dart';
import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/presentation/home/views/home_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(
                SearchRoute(mediaType: MediaType.values[_tabController.index]),
              );
            },
            icon: const Icon(Icons.search_rounded),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Anime'),
            Tab(text: 'Manga'),
            Tab(text: 'Novel'),
          ],
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          HomeView(mediaType: MediaType.ANIME),
          HomeView(mediaType: MediaType.MANGA),
          HomeView(mediaType: MediaType.NOVEL),
        ],
      ),
    );
  }
}
