import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelectorPageMethods {
  final void Function(UserEntityImpl user) toggleSelection;
  final Future<void> Function({DataRequest? dataRequest}) loadUsers;

  UserSelectorPageMethods({
    required this.toggleSelection,
    required this.loadUsers,
  });
}
