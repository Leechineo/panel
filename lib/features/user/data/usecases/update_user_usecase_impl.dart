import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/repositories/user_repository.dart';
import 'package:leechineo_panel/features/user/domain/usecases/update_user_usecase.dart';

class UpdateUserUseCaseImpl implements UpdateUserUseCase {
  final UserRepository _userRepository;

  UpdateUserUseCaseImpl(this._userRepository);

  @override
  Future<UserEntity> call(UpdateUserDTO updateUserDTO) async {
    final updatedUser = await _userRepository.updateUser(updateUserDTO);
    return updatedUser;
  }
}
