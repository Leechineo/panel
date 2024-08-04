import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/auth/domain/repositories/auth_repository.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/get_authenticated_user_usecase.dart';

class GetAuthenticatedUserUseCaseImpl implements GetAuthenticatedUserUseCase {
  late final AuthRepository _authRepository;
  GetAuthenticatedUserUseCaseImpl(final AuthRepository authRepository) {
    _authRepository = authRepository;
  }
  @override
  Future<UserEntity> call() async {
    final user = await _authRepository.getAuthenticatedUser();
    return user;
  }
}
