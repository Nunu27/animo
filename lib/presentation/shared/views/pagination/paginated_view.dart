import 'package:animo/core/utils/handle_error.dart';
import 'package:animo/domain/entities/paginated_data.dart';
import 'package:animo/presentation/shared/views/pagination/paginated_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedView<T> extends StatefulWidget {
  final PaginatedController<int, T> pagingController;
  final Future<PaginatedData<T>> Function(int page, CancelToken? token)
      fetchData;
  final Widget child;

  const PaginatedView({
    super.key,
    required this.pagingController,
    required this.fetchData,
    required this.child,
  });

  @override
  State<PaginatedView<T>> createState() => _PaginatedViewState<T>();
}

class _PaginatedViewState<T> extends State<PaginatedView<T>> {
  DateTime? id;
  bool refreshable = false;

  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetch(pageKey);
    });
    widget.pagingController.addStatusListener((status) {
      final newStatus = isRefreshable(status);
      if (newStatus == refreshable) return;

      setState(() {
        refreshable = newStatus;
      });
    });
  }

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

  void _fetch(int page) async {
    final token = CancelToken();
    widget.pagingController.token = token;
    final result = await handleError(
      widget.fetchData(page, widget.pagingController.token),
    );

    if (!mounted || token.isCancelled) return;

    result.fold(
      (error) => widget.pagingController.error = error,
      (data) {
        if (data.haveNext) {
          widget.pagingController.appendPage(data.items, page + 1);
        } else {
          widget.pagingController.appendLastPage(data.items);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => refreshable,
      onRefresh: () => Future.sync(widget.pagingController.refresh),
      child: widget.child,
    );
  }
}
