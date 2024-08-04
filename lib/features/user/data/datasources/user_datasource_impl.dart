import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/data/models/user_model.dart';
import 'package:leechineo_panel/features/user/domain/datasource/user_datasource.dart';
import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/mappers/create_user_dto_mapper.dart';
import 'package:leechineo_panel/features/user/domain/mappers/update_user_dto_mapper.dart';

class UserDatasourceImpl extends AppDatasource implements UserDatasource {
  final CreateUserDTOMapper _createUserDTOMapper;
  final UpdateUserDTOMapper _updateUserDTOMapper;
  final HttpAdapter _httpAdapter;

  UserDatasourceImpl({
    required CreateUserDTOMapper createUserDTOMapper,
    required UpdateUserDTOMapper updateUserDTOMapper,
    required HttpAdapter httpAdapter,
  })  : _createUserDTOMapper = createUserDTOMapper,
        _updateUserDTOMapper = updateUserDTOMapper,
        _httpAdapter = httpAdapter;

  @override
  Future<UserEntity> createUser(CreateUserDTO createUserDTO) async {
    final createdUser = await exec<UserEntity>(
      () async {
        final response = await _httpAdapter.post(
          '/users/',
          data: _createUserDTOMapper.fromDTOToMap(createUserDTO),
        );
        final createdUser = UserModel.fromMap(response.data);
        return createdUser;
      },
    );
    return createdUser;
  }

  @override
  Future<UserEntity> getUser(String userId) async {
    final user = await exec<UserEntity>(() async {
      final response = await _httpAdapter.get('/users/$userId');
      final user = UserModel.fromMap(response.data);
      return user;
    });
    return user;
  }

  @override
  Future<PaginatedResultOutput<UserEntity>> getUsers(
    DataRequest dataRequest,
  ) async {
    final users = await exec<PaginatedResultOutput<UserEntity>>(() async {
      final response = await _httpAdapter.get('/users/', params: {
        'page': dataRequest.pagination.page,
        'limit': dataRequest.pagination.limit,
      });
      final paginatedUsers = PaginatedResultOutput<UserEntity>(
        items: (response.data['items'] as List)
            .map(
              (e) => UserModel.fromMap(e),
            )
            .toList(),
        total: response.data['total'],
      );
      return paginatedUsers;
    });
    return users;
  }

  @override
  Future<UserEntity> updateUser(UpdateUserDTO updateUserDTO) async {
    final updatedUser = await exec<UserEntity>(() async {
      final response = await _httpAdapter.patch(
        '/users/${updateUserDTO.id}/',
        data: _updateUserDTOMapper.fromDTOToMap(updateUserDTO),
      );
      final user = UserModel.fromMap(response.data);
      return user;
    });
    return updatedUser;
  }
}
