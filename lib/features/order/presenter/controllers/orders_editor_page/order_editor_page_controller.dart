import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_editor_page/order_editor_page_data.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_editor_page/order_editor_page_methods.dart';

class OrderEditorPageController<V>
    extends AppController<OrderEditorPageData, OrderEditorPageMethods> {
  final String orderId;

  OrderEditorPageController({
    required this.orderId,
  });

  @override
  OrderEditorPageMethods defineMethods() {
    return OrderEditorPageMethods();
  }

  @override
  OrderEditorPageData defineData() {
    return OrderEditorPageData();
  }
}
