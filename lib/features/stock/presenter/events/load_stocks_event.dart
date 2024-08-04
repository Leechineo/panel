import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';

class LoadStocksEvent extends AppControllerEvent {
  LoadStocksEvent({super.data}) {
    super.id = 'savedStock';
    listen();
  }
}
