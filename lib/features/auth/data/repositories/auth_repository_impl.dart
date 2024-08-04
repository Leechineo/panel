import 'package:leechineo_panel/features/auth/domain/datasources/auth_datasource.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final user = await authDatasource.login(email, password);
    return user;
  }

  @override
  Future<UserEntity> getAuthenticatedUser() async {
    final user = await authDatasource.getAuthenticatedUser();
    return user;
  }

  @override
  Future<void> logout() async {
    await authDatasource.logout();
  }
}
