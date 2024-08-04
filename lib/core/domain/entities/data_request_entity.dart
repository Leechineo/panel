import 'package:leechineo_panel/core/data/entities/pagination_entity_impl.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';

class DataRequest {
  late final bool refresh;
  late final PaginationArgs pagination;
  late final String searchQuery;

  DataRequest({
    bool? refresh,
    PaginationArgs? paginationArgs,
    String? searchQuery,
  }) {
    this.refresh = refresh ?? false;
    pagination = paginationArgs ??
        PaginationArgsImpl(
          limit: 10,
          page: 1,
        );
    this.searchQuery = searchQuery ?? '';
  }

  Map<String, dynamic> queryParams() {
    return {
      'page': pagination.page,
      'limit': pagination.limit,
      'searchQuery': searchQuery,
    };
  }
}
