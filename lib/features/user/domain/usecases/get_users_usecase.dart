import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class GetUsersUseCase {
  Future<PaginatedResultOutput<UserEntity>> call({DataRequest? dataRequest});
}
