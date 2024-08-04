import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class AddressSelectorPageMethods {
  final void Function(AddressEntityImpl address) toogleAddresSelection;
  final Future<void> Function(UserEntityImpl user) setUser;
  final Future<void> Function({
    required String userId,
    DataRequest? dataRequest,
  }) loadUserAdresses;

  AddressSelectorPageMethods({
    required this.setUser,
    required this.toogleAddresSelection,
    required this.loadUserAdresses,
  });
}
