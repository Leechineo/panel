import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class CreateUserUseCase {
  Future<UserEntity> call(CreateUserDTO createUserDTO);
}
