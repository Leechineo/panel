import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/data/entities/user_entity_impl.dart';

class UserSelectorPageData {
  final bool loading;
  final List<UserEntityImpl> users;
  final Pagination pagination;
  final List<UserEntityImpl> selectedUsers;

  UserSelectorPageData({
    required this.loading,
    required this.users,
    required this.pagination,
    required this.selectedUsers,
  });

  UserSelectorPageData copyWith({
    bool? loading,
    List<UserEntityImpl>? users,
    Pagination? pagination,
    List<UserEntityImpl>? selectedUsers,
  }) {
    return UserSelectorPageData(
      loading: loading ?? this.loading,
      users: users ?? this.users,
      pagination: pagination ?? this.pagination,
      selectedUsers: selectedUsers ?? this.selectedUsers,
    );
  }
}
