import 'package:flutter/foundation.dart';

class PaginatedData<T> {
  final int currentPage;
  final bool haveMore;
  final List<T> data;

  PaginatedData({
    this.currentPage = 1,
    required this.haveMore,
    required this.data,
  });

  PaginatedData<T> copyWith({
    int? currentPage,
    bool? haveMore,
    List<T>? data,
  }) {
    return PaginatedData<T>(
      currentPage: currentPage ?? this.currentPage,
      haveMore: haveMore ?? this.haveMore,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'PaginatedData(currentPage: $currentPage, haveMore: $haveMore, data: $data)';

  @override
  bool operator ==(covariant PaginatedData<T> other) {
    if (identical(this, other)) return true;

    return other.currentPage == currentPage &&
        other.haveMore == haveMore &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => currentPage.hashCode ^ haveMore.hashCode ^ data.hashCode;
}
