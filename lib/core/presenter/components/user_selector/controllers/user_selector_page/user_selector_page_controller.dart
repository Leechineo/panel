import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector_page/user_selector_page_data.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector_page/user_selector_page_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';
import 'package:leechineo_panel/features/user/domain/usecases/get_users_usecase.dart';

class UserSelectorPageController<V>
    extends AppController<UserSelectorPageData, UserSelectorPageMethods> {
  final bool multiple;
  late final GetUsersUseCase _getUsersUseCase;

  UserSelectorPageController({
    required GetUsersUseCase getUsersUseCase,
    required this.multiple,
  }) {
    _getUsersUseCase = getUsersUseCase;
    methods.loadUsers();
  }

  @override
  UserSelectorPageMethods defineMethods() {
    return UserSelectorPageMethods(
      loadUsers: ({dataRequest}) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final paginatedUsers = await _getUsersUseCase(
            dataRequest: dataRequest,
          );
          updateData(
            data.copyWith(
              pagination: Pagination(
                total: paginatedUsers.total,
                limit: data.pagination.limit,
                page: data.pagination.page,
              ),
              users: paginatedUsers.items
                  .map((e) => UserEntityImpl.fromEntity(e))
                  .toList(),
            ),
          );
        } catch (error) {
          catchError(error);
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
      toggleSelection: (user) {
        if (data.selectedUsers.contains(user)) {
          updateData(
            data.copyWith(
              selectedUsers: data.selectedUsers..remove(user),
            ),
          );
        } else {
          if (multiple) {
            updateData(
              data.copyWith(
                selectedUsers: data.selectedUsers..add(user),
              ),
            );
          } else {
            updateData(
              data.copyWith(
                selectedUsers: [user],
              ),
            );
          }
        }
      },
    );
  }

  @override
  UserSelectorPageData defineData() {
    return UserSelectorPageData(
      loading: true,
      users: [],
      pagination: Pagination(
        limit: 10,
        page: 1,
        total: 0,
      ),
      selectedUsers: [],
    );
  }
}
