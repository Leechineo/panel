import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class AddressSelectorMethods {
  final void Function(UserEntityImpl user) updateUser;
  final UserEntityImpl? Function() getUser;
  final void Function(List<AddressEntityImpl> addresses) setAddresses;

  AddressSelectorMethods({
    required this.getUser,
    required this.updateUser,
    required this.setAddresses,
  });
}
