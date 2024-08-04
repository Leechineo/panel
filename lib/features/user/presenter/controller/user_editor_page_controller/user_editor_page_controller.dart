import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/user/data/dtos/create_user_dto_impl.dart';
import 'package:leechineo_panel/features/user/data/dtos/update_user_dto_impl.dart';
import 'package:leechineo_panel/features/user/data/models/user_model.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/user/domain/usecases/create_user_usecase.dart';
import 'package:leechineo_panel/features/user/domain/usecases/get_user_usecase.dart';
import 'package:leechineo_panel/features/user/domain/usecases/update_user_usecase.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_editor_page_controller/user_editor_page_methods.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_editor_page_controller/user_editor_page_form.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_editor_page_controller/user_editor_page_data.dart';
import 'package:leechineo_panel/features/user/presenter/events/saved_user_event.dart';

class UserEditorController
    extends AppController<UserPageEditorData, UserEditorPageMethods> {
  final String userId;

  late UserEditorPageForm form;

  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final GetUserUseCase getUserUseCase;
  final SavedUserEvent savedUserEvent;

  UserEditorController({
    required this.userId,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.savedUserEvent,
    required this.getUserUseCase,
  }) {
    methods.loadUser(userId);
  }

  @override
  UserEditorPageMethods defineMethods() {
    return UserEditorPageMethods(
      createUser: (user, password) async {
        updateData(
          data.copyWith(
            saving: true,
          ),
        );
        try {
          await createUserUseCase(
            CreateUserDTOImpl(
              admin: user.admin,
              name: user.name,
              surname: user.surname,
              birthday: user.birthday,
              cpf: user.cpf,
              email: user.email,
              password: password,
              verifiedEmail: user.verifiedEmail,
            ),
          );
          dispatchEvent(savedUserEvent);
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            saving: false,
          ),
        );
      },
      updateUser: (user, password) async {
        updateData(
          data.copyWith(
            saving: true,
          ),
        );
        try {
          await updateUserUseCase(
            UpdateUserDTOImpl(
              id: user.id,
              admin: user.admin,
              name: user.name,
              surname: user.surname,
              birthday: user.birthday,
              cpf: user.cpf,
              email: user.email,
              password: password,
              verifiedEmail: user.verifiedEmail,
            ),
          );
          dispatchEvent(savedUserEvent);
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            saving: false,
          ),
        );
      },
      loadUser: (userId) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        form = UserEditorPageForm(
          UserModel.newWith(),
        );
        try {
          late UserModel user;
          if (userId == 'null') {
            user = UserModel.newWith();
          } else {
            final userEntity = await getUserUseCase(userId);
            user = UserModel.fromEntity(userEntity);
          }
          updateData(
            data.copyWith(
              user: user,
              editUser: user,
            ),
          );
          form = UserEditorPageForm(
            user,
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
      updateUserName: (name) => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            name: name,
          ),
        ),
      ),
      updateUserSurname: (surname) => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            surname: surname,
          ),
        ),
      ),
      updateBirthday: (birthday) => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            birthday: UserBirthday.fromDate(birthday),
          ),
        ),
      ),
      updateUserCpf: (cpf) => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            cpf: cpf,
          ),
        ),
      ),
      updateEmail: (email) => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            email: email,
          ),
        ),
      ),
      toggleAdmin: () => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            admin: !data.editUser.admin,
          ),
        ),
      ),
      toggleVerifiedEmail: () => updateData(
        data.copyWith(
          editUser: data.editUser.copyWith(
            verifiedEmail: !data.editUser.verifiedEmail,
          ),
        ),
      ),
    );
  }

  @override
  UserPageEditorData defineData() {
    return UserPageEditorData(
      user: UserModel.newWith(),
      editUser: UserModel.newWith(),
      saving: false,
      loading: true,
    );
  }
}
