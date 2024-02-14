import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:animo/models/paginated_data.dart';
import 'package:animo/utils/utils.dart';
import 'package:animo/widgets/error_view.dart';
import 'package:animo/widgets/loader.dart';

class PaginatedView<T> extends StatefulWidget {
  final Future<PaginatedData<T>> Function(int page) fetcher;
  final Widget Function(List<T> data) onData;
  final Widget Function()? onLoading;
  final RefreshController? refreshController;

  const PaginatedView({
    super.key,
    this.refreshController,
    required this.fetcher,
    required this.onData,
    this.onLoading,
  });

  @override
  State<PaginatedView<T>> createState() => _PaginatedViewState<T>();
}

class _PaginatedViewState<T> extends State<PaginatedView<T>> {
  late final RefreshController _refreshController =
      widget.refreshController ?? RefreshController();

  int page = 1;
  bool haveMore = false;
  List<T>? data;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      refresh();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void fetch() async {
    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
    try {
      final result = await widget.fetcher(page);
      if (data == null) {
        data = result.data;
      } else {
        data!.addAll(result.data);
      }
      haveMore = result.haveMore;

      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.loadComplete();
      }
    } catch (e) {
      errorMessage = getError(e).message;
      if (_refreshController.isRefresh) {
        _refreshController.refreshFailed();
      } else {
        page--;
        _refreshController.loadFailed();
      }
    }
    setState(() {});
  }

  void refresh() {
    page = 1;
    data = null;
    fetch();
  }

  void loadMore() {
    if (haveMore) {
      page++;
      fetch();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? errorMessage == null
            ? widget.onLoading == null
                ? const Loader()
                : widget.onLoading!()
            : ErrorView(
                message: errorMessage!,
                onRetry: refresh,
              )
        : SmartRefresher(
            controller: _refreshController,
            header: const WaterDropMaterialHeader(
              distance: 30,
            ),
            onRefresh: refresh,
            onLoading: loadMore,
            enablePullDown: true,
            enablePullUp: true,
            child: widget.onData(data!),
          );
  }
}
