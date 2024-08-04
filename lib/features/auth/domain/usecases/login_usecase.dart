import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class LoginUseCase {
  Future<UserEntity> call(String email, String password);
}
