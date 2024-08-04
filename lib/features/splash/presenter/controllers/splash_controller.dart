import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/get_authenticated_user_usecase.dart';

class SplashMethods {
  Future Function() loadUser;

  SplashMethods({
    required this.loadUser,
  });
}

class SplashData {}

class SplashController extends AppController<SplashData, SplashMethods> {
  late final GetAuthenticatedUserUseCase _getAuthenticatedUserUseCase;

  SplashController(GetAuthenticatedUserUseCase getAuthenticatedUserUseCase) {
    _getAuthenticatedUserUseCase = getAuthenticatedUserUseCase;
    methods.loadUser();
  }

  @override
  void onEventDispatched(AppControllerEvent event) {
    if (event.id == 'userLoggedIn') {
      Modular.to.pushNamedAndRemoveUntil('/home/', (route) => false);
    } else {
      Modular.to.pushNamedAndRemoveUntil('/auth/login/', (route) => false);
    }
  }

  @override
  SplashData defineData() {
    return SplashData();
  }

  @override
  SplashMethods defineMethods() {
    return SplashMethods(
      loadUser: () async {
        try {
          await _getAuthenticatedUserUseCase();
          dispatchEvent(
            AppControllerEvent(
              id: 'userLoggedIn',
              data: data,
            ),
          );
        } catch (e) {
          dispatchEvent(
            AppControllerEvent(
              id: 'userLoggedOut',
              data: data,
            ),
          );
        }
      },
    );
  }
}
