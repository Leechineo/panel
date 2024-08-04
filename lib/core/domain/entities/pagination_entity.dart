abstract class PaginationArgs {
  final int page;
  final int limit;

  PaginationArgs({
    required this.page,
    required this.limit,
  });
}

class PaginatedResultOutput<T> {
  final List<T> items;
  final int total;

  PaginatedResultOutput({
    required this.items,
    required this.total,
  });
}

class Pagination {
  final int total;
  final int limit;
  final int page;

  Pagination({
    required this.total,
    required this.limit,
    required this.page,
  });
}
