import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelectorData {
  final List<UserEntityImpl> users;

  UserSelectorData({
    required this.users,
  });

  UserSelectorData copyWith({
    List<UserEntityImpl>? users,
  }) {
    return UserSelectorData(
      users: users ?? this.users,
    );
  }
}
