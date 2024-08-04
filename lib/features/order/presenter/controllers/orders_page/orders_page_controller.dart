import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_page/orders_page_data.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_page/orders_page_methods.dart';

class OrdersPageController<V>
    extends AppController<OrdersPageData, OrdersPageMethods> {
  OrdersPageController();

  @override
  OrdersPageMethods defineMethods() {
    return OrdersPageMethods(
      goToOrderEditor: (orderId) {
        Modular.to.navigate('/home/order/editor/$orderId/');
      },
    );
  }

  @override
  OrdersPageData defineData() {
    return OrdersPageData();
  }
}
