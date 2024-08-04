import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/product/presenter/pages/product_page.dart';

class ProductModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const ProductPage(),
    );
  }
}
