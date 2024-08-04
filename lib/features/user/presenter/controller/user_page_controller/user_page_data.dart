import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class UserPageData {
  final bool loading;
  final List<UserEntity> users;
  final UserEntity currentUser;
  final Pagination pagination;

  UserPageData({
    required this.loading,
    required this.users,
    required this.currentUser,
    required this.pagination,
  });

  UserPageData copyWith({
    bool? loading,
    List<UserEntity>? users,
    Pagination? pagination,
    UserEntity? currentUser,
  }) {
    return UserPageData(
      loading: loading ?? this.loading,
      users: users ?? this.users,
      pagination: pagination ?? this.pagination,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
