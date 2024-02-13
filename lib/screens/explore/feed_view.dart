import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:animo/models/base_data.dart';
import 'package:animo/providers/api_provider.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';

class FeedView extends ConsumerStatefulWidget {
  const FeedView({
    super.key,
    required this.mediaType,
  });

  final MediaType mediaType;

  @override
  ConsumerState<FeedView> createState() => _ExploreMediaFutureState();
}

class _ExploreMediaFutureState extends ConsumerState<FeedView> {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void refresh() {
    ref.invalidate(getFeedProvider(type: widget.mediaType));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getFeedProvider(type: widget.mediaType)).when(
          data: (data) {
            if (_refreshController.isRefresh) {
              _refreshController.refreshCompleted();
            }

            return Scrollbar(
              interactive: true,
              thickness: 8,
              radius: const Radius.circular(36),
              controller: _scrollController,
              child: SmartRefresher(
                header: const WaterDropMaterialHeader(),
                controller: _refreshController,
                onRefresh: refresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: data.length,
                  itemBuilder: (context, index) => data[index].build(),
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            if (_refreshController.isRefresh) {
              _refreshController.refreshFailed();
            }

            return ErrorView(
              message: getError(error).message,
              onRetry: refresh,
            );
          },
          loading: () => const Loader(),
        );
  }
}
