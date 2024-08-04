import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class AddressCreatorData {
  final bool zipcodeValidated;
  final AddressEntityImpl editingAdress;
  final UserEntity user;

  AddressCreatorData({
    required this.zipcodeValidated,
    required this.editingAdress,
    required this.user,
  });

  AddressCreatorData copyWith({
    bool? zipcodeValidated,
    AddressEntityImpl? editingAdress,
    UserEntity? user,
  }) {
    return AddressCreatorData(
      zipcodeValidated: zipcodeValidated ?? this.zipcodeValidated,
      editingAdress: editingAdress ?? this.editingAdress,
      user: user ?? this.user,
    );
  }
}
