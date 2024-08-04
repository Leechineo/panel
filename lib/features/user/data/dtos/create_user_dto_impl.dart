import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';

class CreateUserDTOImpl extends CreateUserDTO {
  CreateUserDTOImpl({
    required super.admin,
    required super.name,
    required super.surname,
    required super.birthday,
    required super.cpf,
    required super.email,
    required super.password,
    required super.verifiedEmail,
  });
}
