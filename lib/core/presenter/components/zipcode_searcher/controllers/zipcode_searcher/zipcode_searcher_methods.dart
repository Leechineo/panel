import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';

class ZipcodeSearcherMethods {
  final Future<AddressEntityImpl?> Function(String zipcode) searchZipcode;
  final void Function(
    void Function(
      AddressEntityImpl address,
    ) onFound,
  ) submitForm;
  ZipcodeSearcherMethods({
    required this.searchZipcode,
    required this.submitForm,
  });
}
