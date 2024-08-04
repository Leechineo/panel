import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

abstract class UpdateUserDTO {
  final String id;
  final bool? admin;
  final String? name;
  final String? surname;
  final UserBirthday? birthday;
  final String? cpf;
  final String? email;
  final String? password;
  final bool? verifiedEmail;

  UpdateUserDTO({
    required this.id,
    this.admin,
    this.name,
    this.surname,
    this.birthday,
    this.cpf,
    this.email,
    this.password,
    this.verifiedEmail,
  });
}
