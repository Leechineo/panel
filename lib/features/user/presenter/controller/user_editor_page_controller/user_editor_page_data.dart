import 'package:leechineo_panel/features/user/data/models/user_model.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class UserPageEditorData {
  final UserEntity user;
  final UserModel editUser;

  final bool saving;
  final bool loading;

  UserPageEditorData({
    required this.user,
    required this.editUser,
    required this.saving,
    required this.loading,
  });

  UserPageEditorData copyWith({
    UserEntity? user,
    UserModel? editUser,
    bool? saving,
    bool? loading,
  }) {
    return UserPageEditorData(
      user: user ?? this.user,
      editUser: editUser ?? this.editUser,
      saving: saving ?? this.saving,
      loading: loading ?? this.loading,
    );
  }
}
