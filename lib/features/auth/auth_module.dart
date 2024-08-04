import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/auth/data/usecases/login_usecase_impl.dart';
import 'package:leechineo_panel/features/auth/presenter/controllers/login_page_controller.dart';
import 'package:leechineo_panel/features/auth/presenter/pages/login_page.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(() => LoginPageController(i.get<LoginUseCaseImpl>()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/login/',
      child: (context) => LoginPage(
        controller: Modular.get<LoginPageController>(),
      ),
    );
  }
}
