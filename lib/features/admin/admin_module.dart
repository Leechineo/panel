import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/admin/presenter/pages/admin_page.dart';

class AdminModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const AdminPage(),
    );
  }
}
