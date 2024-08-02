import 'package:animo/domain/entities/paginated_data.dart';

class PaginatedDataDto<T> extends PaginatedData<T> {
  const PaginatedDataDto({
    super.total,
    super.current = 1,
    required super.haveNext,
    required super.items,
  });

  factory PaginatedDataDto.fromAnilist(
    Map<String, dynamic> map,
    String itemsKey,
    T Function(Map<String, dynamic>) parseItem,
  ) {
    final page = map['Page'];
    final pageInfo = page['pageInfo'];

    return PaginatedDataDto(
      total: pageInfo['total'],
      current: pageInfo['currentPage'],
      haveNext: pageInfo['hasNextPage'],
      items: (page[itemsKey] as List).map((item) => parseItem(item)).toList(),
    );
  }
}
