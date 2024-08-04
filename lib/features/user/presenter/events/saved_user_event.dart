import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';

class SavedUserEvent extends AppControllerEvent {
  SavedUserEvent({super.data}) {
    super.id = 'savedUser';
    listen();
  }
}
