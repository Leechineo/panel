import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/address_selector.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector/address_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/controllers/product_options_selector/product_options_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/product_options_selector.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector/user_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/user_selector.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_editor_page/order_editor_page_controller.dart';
import 'package:leechineo_panel/features/order/presenter/widgets/order_payment/order_payment.dart';

class OrderEditorPage extends StatelessWidget {
  final OrderEditorPageController controller;
  final ProductSelectorController productSelectorController;
  final UserSelectorController userSelectorController;
  final AddressSelectorController addressSelectorController;
  final GetFileUrlUseCase getFileUrlUseCase;
  const OrderEditorPage({
    required this.controller,
    required this.productSelectorController,
    required this.userSelectorController,
    required this.addressSelectorController,
    required this.getFileUrlUseCase,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const AppCard(
      //   height: 65,
      //   child: Row(
      //     children: [
      //       Text(''),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 12, 0),
          child: AppFlex(
            maxItemsPerRow: 1,
            maxItemsPerRowMd: 2,
            children: [
              UserSelector(
                controller: userSelectorController,
                onUsersSelected: (users) {
                  addressSelectorController.methods.updateUser(users.first);
                  productSelectorController.methods.defineAddressId('');
                  productSelectorController.methods.updadeShippingMappings();
                },
                height: 250,
              ),
              AddressSelector(
                height: 250,
                onAddressesSelected: (addresses) {
                  if (addresses != null && addresses.isNotEmpty) {
                    productSelectorController.methods.defineAddressId(
                      addresses.first.id,
                    );
                  }
                  productSelectorController.methods.updadeShippingMappings();
                },
                controller: addressSelectorController,
              ),
              ProductSelector(
                height: 350,
                controller: productSelectorController,
                getFileUrlUseCase: getFileUrlUseCase,
              ),
              const OrderPayment(),
            ],
          ),
        ),
      ),
    );
  }
}
