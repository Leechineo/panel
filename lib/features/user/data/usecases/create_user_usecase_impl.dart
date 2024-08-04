import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/repositories/user_repository.dart';
import 'package:leechineo_panel/features/user/domain/usecases/create_user_usecase.dart';

class CreateUserUseCaseImpl implements CreateUserUseCase {
  final UserRepository _userRepository;

  CreateUserUseCaseImpl(this._userRepository);

  @override
  Future<UserEntity> call(CreateUserDTO createUserDTO) async {
    final createdUser = await _userRepository.createUser(createUserDTO);
    return createdUser;
  }
}
