import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class UserPageMethods {
  final void Function({UserEntity? user}) goToEditorPage;
  final Future<void> Function({DataRequest? dataRequest}) loadData;

  UserPageMethods({
    required this.goToEditorPage,
    required this.loadData,
  });
}
