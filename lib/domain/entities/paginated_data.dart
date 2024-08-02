import 'package:equatable/equatable.dart';

class PaginatedData<T> extends Equatable {
  final int? total;
  final int current;
  final bool haveNext;
  final List<T> items;

  const PaginatedData({
    this.total,
    this.current = 1,
    required this.haveNext,
    required this.items,
  });

  @override
  List<Object?> get props => [items, current, haveNext, total];
}
