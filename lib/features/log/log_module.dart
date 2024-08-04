import 'package:flutter_modular/flutter_modular.dart';
import 'package:leechineo_panel/features/log/presenter/pages/log_page.dart';

class LogModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const LogPage(),
    );
  }
}
