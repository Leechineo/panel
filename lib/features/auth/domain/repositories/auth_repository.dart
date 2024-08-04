import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> getAuthenticatedUser();
  Future<void> logout();
}
