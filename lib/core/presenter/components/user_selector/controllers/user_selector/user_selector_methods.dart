import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelectorMethods {
  final void Function(List<UserEntityImpl> users) setUsers;
  UserSelectorMethods({
    required this.setUsers,
  });
}
