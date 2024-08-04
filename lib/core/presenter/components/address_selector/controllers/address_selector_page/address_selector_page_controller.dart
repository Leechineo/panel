import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector_page/address_selector_page_data.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector_page/address_selector_page_methods.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_user_addresses_usecase.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class AddressSelectorPageController<V>
    extends AppController<AddressSelectorPageData, AddressSelectorPageMethods> {
  final bool multiple;
  late final GetUserAddressesUseCase _getUserAddressesUseCase;

  AddressSelectorPageController({
    required GetUserAddressesUseCase getUserAddressesUseCase,
    this.multiple = false,
  }) {
    _getUserAddressesUseCase = getUserAddressesUseCase;
  }

  @override
  AddressSelectorPageMethods defineMethods() {
    return AddressSelectorPageMethods(
      loadUserAdresses: ({dataRequest, required userId}) async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final paginatedAddresses = await _getUserAddressesUseCase(
            dataRequest: dataRequest,
            userId: userId,
          );
          updateData(
            data.copyWith(
              addresses: paginatedAddresses.items
                  .map((e) => AddressEntityImpl.fromEntity(e))
                  .toList(),
            ),
          );
        } catch (error) {
          catchError(error);
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
      setUser: (user) async {
        updateData(
          data.copyWith(
            user: user,
            addresses: [],
          ),
        );
        await methods.loadUserAdresses(
          userId: user.id,
        );
      },
      toogleAddresSelection: (address) {
        if (data.selectedAddresses.contains(address)) {
          updateData(
            data.copyWith(
              selectedAddresses: data.selectedAddresses..remove(address),
            ),
          );
        } else {
          if (multiple) {
            updateData(
              data.copyWith(
                selectedAddresses: data.selectedAddresses..add(address),
              ),
            );
          } else {
            updateData(
              data.copyWith(
                selectedAddresses: [address],
              ),
            );
          }
        }
      },
    );
  }

  @override
  AddressSelectorPageData defineData() {
    return AddressSelectorPageData(
      user: UserEntityImpl.newWith(),
      addresses: [],
      pagination: Pagination(
        limit: 10,
        page: 1,
        total: 0,
      ),
      selectedAddresses: [],
      loading: false,
    );
  }
}
