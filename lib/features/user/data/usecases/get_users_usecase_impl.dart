import 'package:leechineo_panel/core/data/entities/pagination_entity_impl.dart';
import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/repositories/user_repository.dart';
import 'package:leechineo_panel/features/user/domain/usecases/get_users_usecase.dart';

class GetUsersUseCaseImpl implements GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCaseImpl(this._userRepository);

  @override
  Future<PaginatedResultOutput<UserEntity>> call({DataRequest? dataRequest}) {
    final paginatedUsers = _userRepository.getUsers(
      dataRequest ??
          DataRequest(
            paginationArgs: PaginationArgsImpl(
              limit: 10,
              page: 1,
            ),
            refresh: false,
            searchQuery: '',
          ),
    );
    return paginatedUsers;
  }
}
