import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector/user_selector_data.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector/user_selector_methods.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector_page/user_selector_page_controller.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/user/domain/usecases/get_users_usecase.dart';

class UserSelectorController<V>
    extends AppController<UserSelectorData, UserSelectorMethods> {
  final bool multiple;
  final UserSelectorPageController userSelectorPageController;
  final GetUsersUseCase getUsersUseCase;

  UserSelectorController({
    required this.getUsersUseCase,
    this.multiple = true,
  }) : userSelectorPageController = UserSelectorPageController(
          getUsersUseCase: getUsersUseCase,
          multiple: multiple,
        );

  @override
  UserSelectorMethods defineMethods() {
    return UserSelectorMethods(
      setUsers: (users) {
        updateData(
          data.copyWith(
            users: users,
          ),
        );
      },
    );
  }

  @override
  UserSelectorData defineData() {
    return UserSelectorData(
      users: [],
    );
  }
}
