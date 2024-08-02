import 'package:animo/domain/enums/media_type.dart';
import 'package:animo/presentation/shared/controllers/meta_controller.dart';
import 'package:animo/presentation/home/widgets/feed_carousel.dart';
import 'package:animo/presentation/home/widgets/feed_list.dart';
import 'package:animo/presentation/shared/views/error_view.dart';
import 'package:animo/presentation/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  final MediaType mediaType;
  const HomeView({super.key, required this.mediaType});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ref.watch(getFeedProvider(widget.mediaType)).when(
          data: (data) => ListView(
            children: [
              const SizedBox(height: 12),
              FeedCarousel(carouselData: data.carousel),
              const SizedBox(height: 24),
              if (data.popularThisSeason.isNotEmpty)
                FeedList(title: 'Popular', listData: data.popularThisSeason),
              FeedList(title: 'Trending', listData: data.trending),
              if (data.upcoming.isNotEmpty)
                FeedList(title: 'Upcoming', listData: data.upcoming),
            ],
          ),
          error: (error, stackTrace) => ErrorView(
            error: error.toString(),
            onRetry: () {
              ref.invalidate(getFeedProvider(widget.mediaType));
            },
          ),
          loading: () => const Loader(),
        );
  }
}
