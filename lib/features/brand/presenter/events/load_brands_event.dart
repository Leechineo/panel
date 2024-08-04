import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';

class LoadBrandsEvent extends AppControllerEvent {
  LoadBrandsEvent({super.data}) {
    super.id = 'savedBrand';
    listen();
  }
}
