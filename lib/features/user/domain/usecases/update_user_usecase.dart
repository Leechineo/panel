import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class UpdateUserUseCase {
  Future<UserEntity> call(UpdateUserDTO updateUserDTO);
}
