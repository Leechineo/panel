import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class CreateUserDTO {
  final bool admin;
  final String name;
  final String surname;
  final UserBirthday birthday;
  final String cpf;
  final String email;
  final String password;
  final bool verifiedEmail;

  CreateUserDTO({
    required this.admin,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.cpf,
    required this.email,
    required this.password,
    required this.verifiedEmail,
  });
}
