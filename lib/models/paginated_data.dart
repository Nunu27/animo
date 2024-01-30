class PaginatedData<T> {
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
}
