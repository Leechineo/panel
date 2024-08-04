import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/auth/domain/usecases/get_authenticated_user_usecase.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';
import 'package:leechineo_panel/features/user/data/models/user_model.dart';
import 'package:leechineo_panel/features/user/domain/usecases/get_users_usecase.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_page_controller/user_page_data.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_page_controller/user_page_methods.dart';
import 'package:leechineo_panel/features/user/presenter/events/saved_user_event.dart';

class UserPageController extends AppController<UserPageData, UserPageMethods> {
  final GetAuthenticatedUserUseCase getAuthenticatedUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final SavedUserEvent savedUserEvent;

  UserPageController({
    required this.getAuthenticatedUserUseCase,
    required this.getUsersUseCase,
    required this.savedUserEvent,
  }) : super(events: [savedUserEvent]) {
    methods.loadData();
  }

  @override
  void onEventDispatched(AppControllerEvent event) {
    if (event is SavedUserEvent) {
      methods.loadData(
        dataRequest: DataRequest(
          refresh: true,
        ),
      );
    }
  }

  @override
  UserPageMethods defineMethods() {
    return UserPageMethods(
      goToEditorPage: ({user}) {
        Modular.to.pushNamed('/home/user/editor/${user?.id}');
      },
      loadData: ({dataRequest}) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          if (data.currentUser.id.isEmpty) {
            final user = await getAuthenticatedUserUseCase();
            updateData(
              data.copyWith(
                currentUser: user,
              ),
            );
          }
          final paginatedUsers = await getUsersUseCase(
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
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
    );
  }

  @override
  UserPageData defineData() {
    return UserPageData(
      loading: true,
      users: [],
      pagination: Pagination(
        total: 0,
        limit: 10,
        page: 1,
      ),
      currentUser: UserModel.newWith(),
    );
  }
}
