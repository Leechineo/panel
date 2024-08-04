import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/features/auth/data/usecases/get_authenticated_user_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/create_user_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/get_user_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/get_users_usecase_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/update_user_usecase_impl.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_editor_page_controller/user_editor_page_controller.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_page_controller/user_page_controller.dart';
import 'package:leechineo_panel/features/user/presenter/events/saved_user_event.dart';
import 'package:leechineo_panel/features/user/presenter/pages/user_editor_page.dart';
import 'package:leechineo_panel/features/user/presenter/pages/user_page.dart';

class UserModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(SavedUserEvent.new);
    i.addLazySingleton(
      () => UserPageController(
        getAuthenticatedUserUseCase: i.get<GetAuthenticatedUserUseCaseImpl>(),
        getUsersUseCase: i.get<GetUsersUseCaseImpl>(),
        savedUserEvent: i.get<SavedUserEvent>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => UserPage(
        userController: Modular.get<UserPageController>(),
      ),
    );
    r.child(
      '/editor/:id',
      transition: TransitionType.downToUp,
      duration: const Duration(milliseconds: 200),
      child: (context) => UserEditorPage(
        userEditorController: UserEditorController(
          userId: r.args.params['id'],
          getUserUseCase: Modular.get<GetUserUseCaseImpl>(),
          createUserUseCase: Modular.get<CreateUserUseCaseImpl>(),
          updateUserUseCase: Modular.get<UpdateUserUseCaseImpl>(),
          savedUserEvent: Modular.get<SavedUserEvent>(),
        ),
      ),
    );
  }
}
