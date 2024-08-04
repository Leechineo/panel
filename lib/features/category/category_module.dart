import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/category/presenter/pages/category_page.dart';

class CategoryModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const CategoryPage(),
    );
  }
}
