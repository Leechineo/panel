import 'package:leechineo_panel/features/auth/domain/repositories/auth_repository.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/logout_usecase.dart';

class LogoutUseCaseImpl implements LogoutUseCase {
  late final AuthRepository _authRepository;

  LogoutUseCaseImpl(final AuthRepository authRepository) {
    _authRepository = authRepository;
  }
  @override
  Future<void> call() async {
    await _authRepository.logout();
  }
}
