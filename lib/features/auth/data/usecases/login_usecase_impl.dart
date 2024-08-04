import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/auth/domain/repositories/auth_repository.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/login_usecase.dart';

class LoginUseCaseImpl implements LoginUseCase {
  late final AuthRepository _authRepository;
  LoginUseCaseImpl(final AuthRepository authRepository) {
    _authRepository = authRepository;
  }
  @override
  Future<UserEntity> call(String email, String password) async {
    final user = _authRepository.login(email, password);
    return user;
  }
}
