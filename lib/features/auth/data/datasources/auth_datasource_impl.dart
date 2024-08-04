import 'package:leechineo_panel/core/domain/adapters/database_adapter.dart';
import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/features/user/data/models/user_model.dart';
import 'package:leechineo_panel/features/auth/domain/datasources/auth_datasource.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class AuthDatasourceImpl extends AppDatasource implements AuthDatasource {
  late final HttpAdapter _httpAdapter;
  late final DatabaseAdapter _databaseAdapter;

  UserModel? currentUser;

  AuthDatasourceImpl({
    required HttpAdapter httpAdapter,
    required DatabaseAdapter databaseAdapter,
  }) {
    _httpAdapter = httpAdapter;
    _databaseAdapter = databaseAdapter;
  }

  @override
  Future<UserEntity> getAuthenticatedUser() async {
    final user = await exec(
      () async {
        if (currentUser != null) {
          return currentUser!;
        }
        final response = await _httpAdapter.get('/auth/user');
        final user = UserModel.fromMap(response.data['user']);
        currentUser = user;
        return user;
      },
      onCatch: () async {
        await _databaseAdapter.removeValue('auth', 'token');
      },
    );
    return user;
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await exec<UserEntity>(() async {
      final response = await _httpAdapter.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      await _databaseAdapter.writeValue(
          'auth', 'token', response.data['token']);
      final user = UserModel.fromMap(response.data['user']);
      currentUser = user;
      return user;
    });
    return user;
  }

  @override
  Future<void> logout() async {
    await exec(() async {
      await _httpAdapter.post('/auth/logout');
      await _databaseAdapter.removeValue('auth', 'token');
    });
  }
}
