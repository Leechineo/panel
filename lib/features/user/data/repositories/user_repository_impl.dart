import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/domain/datasource/user_datasource.dart';
import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _userDatasource;

  UserRepositoryImpl(this._userDatasource);

  @override
  Future<UserEntity> createUser(CreateUserDTO createUserDTO) async {
    final createdUser = await _userDatasource.createUser(createUserDTO);
    return createdUser;
  }

  @override
  Future<UserEntity> getUser(String userId) async {
    final user = _userDatasource.getUser(userId);
    return user;
  }

  @override
  Future<UserEntity> updateUser(UpdateUserDTO updateUserDTO) async {
    final updatedUser = await _userDatasource.updateUser(updateUserDTO);
    return updatedUser;
  }

  @override
  Future<PaginatedResultOutput<UserEntity>> getUsers(
      DataRequest dataRequest) async {
    final paginatedUsers = await _userDatasource.getUsers(dataRequest);
    return paginatedUsers;
  }
}
