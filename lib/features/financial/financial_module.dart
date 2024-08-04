import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/financial/presenter/pages/financial_page.dart';

class FinancialModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const FinancialPage(),
    );
  }
}
