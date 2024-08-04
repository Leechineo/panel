import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_creator/address_creator_controller.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector/address_selector_data.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector/address_selector_methods.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector_page/address_selector_page_controller.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_address_by_zipcode_usecase.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_user_addresses_usecase.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class AddressSelectorController<V>
    extends AppController<AddressSelectorData, AddressSelectorMethods> {
  final AddressSelectorPageController addressSelectorPageController;
  final AddressCreatorController addressCreatorController;

  AddressSelectorController({
    required GetUserAddressesUseCase getUserAddressesUseCase,
    required GetAddressByZipcodeUseCase getAddressByZipcodeUseCase,
  })  : addressSelectorPageController = AddressSelectorPageController(
          getUserAddressesUseCase: getUserAddressesUseCase,
        ),
        addressCreatorController = AddressCreatorController(
          getAddressByZipcodeUseCase: getAddressByZipcodeUseCase,
        );

  @override
  AddressSelectorMethods defineMethods() {
    return AddressSelectorMethods(
      getUser: () {
        final UserEntityImpl user = addressSelectorPageController.data.user;
        if (user.id.isEmpty) {
          return null;
        }
        return user;
      },
      updateUser: (user) {
        addressSelectorPageController.methods.setUser(user);
        addressCreatorController.methods.updateData(
          AddressEntityImpl.newWith(),
          user,
        );
        updateData(
          data.copyWith(
            addresses: [],
          ),
        );
      },
      setAddresses: (addresses) {
        updateData(
          data.copyWith(
            addresses: addresses,
          ),
        );
      },
    );
  }

  @override
  AddressSelectorData defineData() {
    return AddressSelectorData(
      addresses: [],
    );
  }
}
