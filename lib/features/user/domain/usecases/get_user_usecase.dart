import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class GetUserUseCase {
  Future<UserEntity> call(String userId);
}
