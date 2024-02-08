import 'package:animo/models/base_data.dart';
import 'package:animo/models/media/media_basic.dart';
import 'package:animo/models/paginated_data.dart';
import 'package:animo/repositories/media_repository.dart';
import 'package:animo/widgets/cover_card_with_button.dart';
import 'package:animo/widgets/future_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExploreMediaFuture extends ConsumerStatefulWidget {
  const ExploreMediaFuture({
    super.key,
    required this.mediaType,
    required this.options,
  });

  final MediaType mediaType;
  final List<Map<String, String>> options;

  @override
  ConsumerState<ExploreMediaFuture> createState() => _ExploreMediaFutureState();
}

class _ExploreMediaFutureState extends ConsumerState<ExploreMediaFuture> {
  late final RefreshController _refreshController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return FutureView(
      refreshController: _refreshController,
      future: Future.wait(
        widget.options.map(
          (e) => ref
              .read(mediaRepositoryProvider)
              .filter(widget.mediaType, {'sort': e.keys.first}),
        ),
      ),
      onData: (data) {
        return Scrollbar(
          interactive: true,
          thickness: 8,
          radius: const Radius.circular(36),
          controller: _scrollController,
          child: SmartRefresher(
            header: const WaterDropMaterialHeader(),
            controller: _refreshController,
            onRefresh: () {
              setState(() {});
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final PaginatedData<MediaBasic> media = data[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: CoverCardWithText(
                    media: media,
                    title: widget.options[index].values.first,
                    sortBy: widget.options[index].keys.first,
                    mediatype: widget.mediaType,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
