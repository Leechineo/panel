import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';

class AddressSelectorData {
  final List<AddressEntityImpl> addresses;

  AddressSelectorData({
    required this.addresses,
  });

  AddressSelectorData copyWith({
    List<AddressEntityImpl>? addresses,
  }) {
    return AddressSelectorData(
      addresses: addresses ?? this.addresses,
    );
  }
}
