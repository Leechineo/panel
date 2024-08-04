import 'package:leechineo_panel/core/presenter/components/zipcode_searcher/controllers/zipcode_searcher/zipcode_searcher_controller.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_creator/address_creator_data.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_creator/address_creator_form.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_creator/address_creator_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_address_by_zipcode_usecase.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class AddressCreatorController<V>
    extends AppController<AddressCreatorData, AddressCreatorMethods> {
  late final ZipcodeSearcherController zipcodeSearcherController;
  final AddressCreatorForm form = AddressCreatorForm();

  AddressCreatorController({
    required GetAddressByZipcodeUseCase getAddressByZipcodeUseCase,
  }) {
    zipcodeSearcherController = ZipcodeSearcherController(
      getAddressByZipcodeUseCase: getAddressByZipcodeUseCase,
    );
  }

  @override
  AddressCreatorMethods defineMethods() {
    return AddressCreatorMethods(
      updateData: (address, user) {
        updateData(
          data.copyWith(
            editingAdress: address,
            zipcodeValidated: address.zipcode.isNotEmpty,
            user: user,
          ),
        );
        form.updateForm(
          address: address,
          user: user,
        );
      },
      resetData: () {
        updateData(
          data.copyWith(
            editingAdress: AddressEntityImpl.newWith(),
            user: UserEntityImpl.newWith(),
            zipcodeValidated: false,
          ),
        );
        form.updateForm(
          address: data.editingAdress,
          user: data.user,
        );
      },
    );
  }

  @override
  AddressCreatorData defineData() {
    return AddressCreatorData(
      zipcodeValidated: false,
      editingAdress: AddressEntityImpl.newWith(),
      user: UserEntityImpl.newWith(),
    );
  }
}
