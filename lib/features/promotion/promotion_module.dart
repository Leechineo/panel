import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/promotion/presenter/pages/promotion_page.dart';

class PromotionModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const PromotionPage(),
    );
  }
}
