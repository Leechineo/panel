import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> createUser(CreateUserDTO createUserDTO);
  Future<PaginatedResultOutput<UserEntity>> getUsers(DataRequest dataRequest);
  Future<UserEntity> getUser(String userId);
  Future<UserEntity> updateUser(UpdateUserDTO updateUserDTO);
}
