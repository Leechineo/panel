import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class GetAuthenticatedUserUseCase {
  Future<UserEntity> call();
}
