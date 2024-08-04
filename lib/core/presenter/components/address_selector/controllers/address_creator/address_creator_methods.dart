import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class AddressCreatorMethods {
  final void Function(AddressEntityImpl address, UserEntity user) updateData;
  final void Function() resetData;
  AddressCreatorMethods({
    required this.updateData,
    required this.resetData,
  });
}
