import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/login_usecase.dart';

class LoginPageData {
  final bool loading;

  LoginPageData({
    required this.loading,
  });

  LoginPageData copyWith({
    bool? loading,
  }) {
    return LoginPageData(
      loading: loading ?? this.loading,
    );
  }
}

class LoginPageMethods {
  final void Function(String email, String password) login;

  LoginPageMethods({
    required this.login,
  });
}

class LoginPageController
    extends AppController<LoginPageData, LoginPageMethods> {
  late final LoginUseCase _loginUseCase;
  LoginPageController(final LoginUseCase loginUseCase) {
    _loginUseCase = loginUseCase;
  }

  @override
  void onEventDispatched(AppControllerEvent event) {
    if (event.id == 'userLoggedIn') {
      Modular.to.pushNamedAndRemoveUntil('/home/', (route) => false);
    }
  }

  @override
  LoginPageData defineData() {
    return LoginPageData(
      loading: false,
    );
  }

  @override
  LoginPageMethods defineMethods() {
    return LoginPageMethods(
      login: (email, password) async {
        updateData(
          data.copyWith(loading: true),
        );
        try {
          await _loginUseCase(email, password);
          dispatchEvent(
            AppControllerEvent(
              id: 'userLoggedIn',
              data: data,
            ),
          );
        } catch (e) {
          if (e is AppError) {
            catchError(e);
          }
        }
        updateData(
          data.copyWith(loading: false),
        );
      },
    );
  }
}
