import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class AddressSelectorPageData {
  final UserEntityImpl user;
  final List<AddressEntityImpl> addresses;
  final bool loading;
  final List<AddressEntityImpl> selectedAddresses;
  final Pagination pagination;

  AddressSelectorPageData({
    required this.user,
    required this.addresses,
    required this.loading,
    required this.selectedAddresses,
    required this.pagination,
  });

  AddressSelectorPageData copyWith({
    UserEntityImpl? user,
    List<AddressEntityImpl>? addresses,
    List<AddressEntityImpl>? selectedAddresses,
    bool? loading,
    Pagination? pagination,
  }) {
    return AddressSelectorPageData(
      user: user ?? this.user,
      addresses: addresses ?? this.addresses,
      loading: loading ?? this.loading,
      selectedAddresses: selectedAddresses ?? this.selectedAddresses,
      pagination: pagination ?? this.pagination,
    );
  }
}
