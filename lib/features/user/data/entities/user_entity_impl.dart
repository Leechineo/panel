import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class UserEntityImpl extends UserEntity {
  UserEntityImpl({
    required super.id,
    required super.name,
    required super.surname,
    required super.birthday,
    required super.cpf,
    required super.email,
    required super.verifiedEmail,
    required super.createdAt,
  });

  UserEntityImpl copyWith({
    String? id,
    bool? admin,
    String? name,
    String? surname,
    String? email,
    bool? verifiedEmail,
    String? cpf,
    UserBirthday? birthday,
    DateTime? createdAt,
  }) {
    return UserEntityImpl(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      verifiedEmail: verifiedEmail ?? this.verifiedEmail,
      cpf: cpf ?? this.cpf,
      birthday: birthday ?? this.birthday,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserEntityImpl.newWith({
    String? id,
    bool? admin,
    String? name,
    String? surname,
    String? email,
    bool? verifiedEmail,
    String? cpf,
    UserBirthday? birthday,
    DateTime? createdAt,
  }) {
    final defaultBirthdayDateTime = DateTime.now().subtract(
      const Duration(days: 18 * 365),
    );
    final defaultBirthday = UserBirthday(
      day: defaultBirthdayDateTime.day.toString(),
      month: defaultBirthdayDateTime.month.toString(),
      year: defaultBirthdayDateTime.year.toString(),
    );
    return UserEntityImpl(
      id: id ?? '',
      name: name ?? '',
      surname: surname ?? '',
      email: email ?? '',
      verifiedEmail: verifiedEmail ?? false,
      cpf: cpf ?? '',
      birthday: birthday ?? defaultBirthday,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  factory UserEntityImpl.fromEntity(UserEntity userEntity) {
    return UserEntityImpl(
      id: userEntity.id,
      name: userEntity.name,
      surname: userEntity.surname,
      birthday: userEntity.birthday,
      cpf: userEntity.cpf,
      email: userEntity.email,
      verifiedEmail: userEntity.verifiedEmail,
      createdAt: userEntity.createdAt,
    );
  }
}
