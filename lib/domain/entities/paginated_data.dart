import 'package:equatable/equatable.dart';

class PaginatedData<T> extends Equatable {
  final int? total;
  final int current;
  final bool haveNext;
  final List<T> items;

  const PaginatedData({
    required this.total,
    required this.current,
    required this.haveNext,
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}
