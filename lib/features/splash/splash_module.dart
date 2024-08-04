import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/auth/auth_module.dart';
import 'package:leechineo_panel/features/auth/data/usecases/get_authenticated_user_usecase_impl.dart';
import 'package:leechineo_panel/features/splash/presenter/controllers/splash_controller.dart';
import 'package:leechineo_panel/features/splash/presenter/pages/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [AuthModule()];
  @override
  void binds(Injector i) {
    i.addLazySingleton<SplashController>(
      () => SplashController(
        i.get<GetAuthenticatedUserUseCaseImpl>(),
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => SplashPage(
        splashController: Modular.get<SplashController>(),
      ),
    );
  }
}
