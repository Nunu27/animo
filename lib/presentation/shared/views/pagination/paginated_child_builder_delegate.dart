import 'package:animo/presentation/shared/views/error_view.dart';
import 'package:animo/presentation/shared/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedChildBuilderDelegate<PageKeyType, ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  PaginatedChildBuilderDelegate({
    double? loaderHeight,
    required super.itemBuilder,
    required PagingController<PageKeyType, ItemType> pagingController,
  }) : super(
          firstPageProgressIndicatorBuilder: (context) => SizedBox(
            height: loaderHeight,
            child: const Loader(),
          ),
          firstPageErrorIndicatorBuilder: (context) => ErrorView(
            error: pagingController.error,
            onRetry: pagingController.retryLastFailedRequest,
          ),
          newPageErrorIndicatorBuilder: (context) => ErrorView(
            error: pagingController.error,
            onRetry: pagingController.retryLastFailedRequest,
          ),
        );
}
