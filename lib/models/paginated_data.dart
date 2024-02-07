import 'package:animo/models/abstract/mappable.dart';
import 'package:flutter/foundation.dart';

class PaginatedData<T extends Mappable> {
  final int? total;
  final int currentPage;
  final bool haveMore;
  final List<T> data;

  PaginatedData({
    this.total,
    this.currentPage = 1,
    this.haveMore = false,
    required this.data,
  });

  PaginatedData<T> copyWith({
    int? total,
    int? currentPage,
    bool? haveMore,
    List<T>? data,
  }) {
    return PaginatedData<T>(
      total: total ?? this.total,
      currentPage: currentPage ?? this.currentPage,
      haveMore: haveMore ?? this.haveMore,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'currentPage': currentPage,
      'haveMore': haveMore,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory PaginatedData.fromMap(
      Map<String, dynamic> map, T Function(Map<String, dynamic>) fromMap) {
    return PaginatedData<T>(
      total: map['total'] != null ? map['total'] as int : null,
      currentPage: map['currentPage'] != null ? map['currentPage'] as int : 1,
      haveMore: map['haveMore'] as bool,
      data: List<T>.from(
        (map['data'] as List).map<T>(
          (x) => fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'PaginatedData(total: $total, currentPage: $currentPage, haveMore: $haveMore, data: $data)';
  }

  @override
  bool operator ==(covariant PaginatedData<T> other) {
    if (identical(this, other)) return true;

    return other.total == total &&
        other.currentPage == currentPage &&
        other.haveMore == haveMore &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return total.hashCode ^
        currentPage.hashCode ^
        haveMore.hashCode ^
        data.hashCode;
  }
}
