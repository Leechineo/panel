import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/shipping_method/presenter/pages/shipping_method_page.dart';

class ShippingMethodModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const ShippingMethodPage(),
    );
  }
}
