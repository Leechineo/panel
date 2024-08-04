import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';

class UpdateUserDTOImpl extends UpdateUserDTO {
  UpdateUserDTOImpl({
    required super.id,
    super.admin,
    super.name,
    super.surname,
    super.birthday,
    super.cpf,
    super.email,
    super.password,
    super.verifiedEmail,
  });
}
