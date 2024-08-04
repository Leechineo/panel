import 'package:leechineo_panel/features/user/domain/dtos/update_user_dto.dart';
import 'package:leechineo_panel/features/user/domain/mappers/update_user_dto_mapper.dart';

class UpdateUserDTOMapperImpl extends UpdateUserDTOMapper {
  @override
  Map<String, dynamic> fromDTOToMap(UpdateUserDTO dto) {
    return {
      'admin': dto.admin,
      'birthday': dto.birthday?.toMap(),
      'cpf': dto.cpf,
      'email': dto.email,
      'password': dto.password,
      'name': dto.name,
      'surname': dto.surname,
      'verifiedEmail': dto.verifiedEmail,
    };
  }

  @override
  Map<String, dynamic> fromEntityToMap(entity) {
    throw UnimplementedError();
  }

  @override
  UpdateUserDTO fromMapToDTO(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  fromMapToEntity(Map<String, dynamic> map) {
    throw UnimplementedError();
  }
}
