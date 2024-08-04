import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class UserEditorPageMethods {
  final Future<void> Function(UserEntity user, String password) createUser;
  final Future<void> Function(UserEntity user, String password) updateUser;
  final Future<void> Function(String userId) loadUser;

  final void Function(String name) updateUserName;
  final void Function(String surname) updateUserSurname;
  final void Function(DateTime birthday) updateBirthday;
  final void Function(String cpf) updateUserCpf;
  final void Function(String email) updateEmail;
  final void Function() toggleAdmin;
  final void Function() toggleVerifiedEmail;

  UserEditorPageMethods({
    required this.createUser,
    required this.updateUser,
    required this.loadUser,
    required this.updateUserName,
    required this.updateUserSurname,
    required this.updateBirthday,
    required this.updateUserCpf,
    required this.updateEmail,
    required this.toggleAdmin,
    required this.toggleVerifiedEmail,
  });
}
