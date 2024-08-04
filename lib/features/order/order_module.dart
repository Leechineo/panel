import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/core_module.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_selector/address_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/presentation/controllers/product_options_selector/product_options_selector_controller.dart';
import 'package:leechineo_panel/core/presenter/components/user_selector/controllers/user_selector/user_selector_controller.dart';
import 'package:leechineo_panel/features/address/data/usecases/get_address_by_zipcode_usecase_impl.dart';
import 'package:leechineo_panel/features/address/data/usecases/get_user_adresses_usecase_impl.dart';
import 'package:leechineo_panel/features/cloud_file/data/usecases/get_file_url_usecase_impl.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_editor_page/order_editor_page_controller.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_page/orders_page_controller.dart';
import 'package:leechineo_panel/features/order/presenter/pages/order_editor_page.dart';
import 'package:leechineo_panel/features/order/presenter/pages/order_page.dart';
import 'package:leechineo_panel/features/product/data/usecases/get_products_usecase_impl.dart';
import 'package:leechineo_panel/features/shipping_method/data/usecases/calculate_shipping_usecase.dart';
import 'package:leechineo_panel/features/shipping_method/data/usecases/get_all_shipping_methods_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/get_all_stocks_usecase_impl.dart';
import 'package:leechineo_panel/features/stock/data/usecases/get_stock_by_id_impl.dart';
import 'package:leechineo_panel/features/user/data/usecases/get_users_usecase_impl.dart';

class OrderModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<OrdersPageController>(
      () => OrdersPageController(),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
    i.addLazySingleton<UserSelectorController>(
      () => UserSelectorController(
        getUsersUseCase: i.get<GetUsersUseCaseImpl>(),
        multiple: false,
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
    i.addLazySingleton<AddressSelectorController>(
      () => AddressSelectorController(
        getAddressByZipcodeUseCase: i.get<GetAddressByZipcodeUseCaseImpl>(),
        getUserAddressesUseCase: i.get<GetUserAddressesUseCaseImpl>(),
      ),
      config: BindConfig(
        onDispose: (value) => value.dispose(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => OrdersPage(
        controller: Modular.get<OrdersPageController>(),
      ),
    );
    r.child(
      '/editor/:id/',
      child: (context) => OrderEditorPage(
        controller: OrderEditorPageController(
          orderId: r.args.params['id'],
        ),
        productSelectorController: ProductSelectorController(
          getAllStocksUseCase: Modular.get<GetAllStocksUseCaseImpl>(),
          getStockByIdUseCase: Modular.get<GetStockByIdUseCaseImpl>(),
          getProductsUseCase: Modular.get<GetProductsUseCaseImpl>(),
          getAllShippingMethodsUseCase:
              Modular.get<GetAllShippingMethodsUseCaseImpl>(),
          calculateShippingUseCase: Modular.get<CalculateShippingUseCaseImpl>(),
        ),
        userSelectorController: Modular.get<UserSelectorController>(),
        addressSelectorController: Modular.get<AddressSelectorController>(),
        getFileUrlUseCase: Modular.get<GetFileUrlUseCaseImpl>(),
      ),
    );
  }
}
