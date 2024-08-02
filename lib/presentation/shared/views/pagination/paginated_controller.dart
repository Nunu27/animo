import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginatedController<PageKeyType, ItemType>
    extends PagingController<PageKeyType, ItemType> {
  CancelToken? _token;

  PaginatedController({required super.firstPageKey});

  CancelToken? get token => _token;
  set token(CancelToken? token) {
    _token?.cancel();
    _token = token;
  }

  @override
  void refresh() {
    if (super.value.status == PagingStatus.loadingFirstPage) {
      super.notifyPageRequestListeners(super.firstPageKey);
    } else {
      super.refresh();
    }
  }
}
