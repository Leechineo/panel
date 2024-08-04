import 'package:leechineo_panel/features/user/domain/dtos/create_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/mappers/create_user_dto_mapper.dart';

class CreateUserDTOMapperImpl extends CreateUserDTOMapper {
  @override
  Map<String, dynamic> fromDTOToMap(CreateUserDTO dto) {
    return {
      'admin': dto.admin,
      'name': dto.name,
      'surname': dto.surname,
      'birthday': dto.birthday.toMap(),
      'cpf': dto.cpf,
      'email': dto.email,
      'password': dto.password,
      'verifiedEmail': dto.verifiedEmail,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    throw UnimplementedError();
  }

  @override
  CreateUserDTO fromMapToDTO(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  fromMapToEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
