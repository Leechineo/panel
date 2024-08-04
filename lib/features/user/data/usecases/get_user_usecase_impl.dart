import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/repositories/user_repository.dart';
import 'package:leechineo_panel/features/user/domain/usecases/get_user_usecase.dart';

class GetUserUseCaseImpl implements GetUserUseCase {
  final UserRepository _userRepository;

  GetUserUseCaseImpl(this._userRepository);

  @override
  Future<UserEntity> call(String userId) async {
    final user = await _userRepository.getUser(userId);
    return user;
  }
}
