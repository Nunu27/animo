import 'package:animo/models/paginated_data.dart';
import 'package:animo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedView<T> extends StatefulWidget {
  final PagingController<int, T> pagingController;
  final Future<PaginatedData<T>> Function(int page) fetcher;
  final Widget child;

  const PaginatedView({
    super.key,
    required this.pagingController,
    required this.fetcher,
    required this.child,
  });

  @override
  State<PaginatedView<T>> createState() => _PaginatedViewState<T>();
}

class _PaginatedViewState<T> extends State<PaginatedView<T>> {
  bool refreshable = false;

  bool isRefreshable(PagingStatus status) {
    switch (status) {
      case PagingStatus.completed:
      case PagingStatus.ongoing:
      case PagingStatus.subsequentPageError:
        return true;

      default:
        return false;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetch(pageKey);
    });
    widget.pagingController.addStatusListener((status) {
      setState(() {
        refreshable = isRefreshable(status);
      });
    });
  }

  void _fetch(int page) async {
    try {
      final result = await widget.fetcher(page);

      if (result.haveMore) {
        widget.pagingController.appendPage(result.data, page + 1);
      } else {
        widget.pagingController.appendLastPage(result.data);
      }
    } catch (e) {
      if (mounted) {
        widget.pagingController.error = getError(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => refreshable,
      onRefresh: () => Future.sync(
        () => widget.pagingController.refresh(),
      ),
      child: widget.child,
    );
  }
}
