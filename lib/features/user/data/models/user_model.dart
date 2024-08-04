import 'dart:convert';

import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';

class UserModel implements UserEntity {
  @override
  final String id;
  @override
  final bool admin;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String email;
  @override
  final bool verifiedEmail;
  @override
  final String cpf;
  @override
  final UserBirthday birthday;
  @override
  final DateTime createdAt;
  UserModel({
    required this.id,
    required this.admin,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.cpf,
    required this.email,
    required this.verifiedEmail,
    required this.createdAt,
  });

  UserModel copyWith({
    String? id,
    bool? admin,
    String? name,
    String? surname,
    UserBirthday? birthday,
    String? cpf,
    String? email,
    bool? verifiedEmail,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      admin: admin ?? this.admin,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      birthday: birthday ?? this.birthday,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      verifiedEmail: verifiedEmail ?? this.verifiedEmail,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'admin': admin,
      'name': name,
      'surname': surname,
      'birthday': birthday.toMap(),
      'cpf': cpf,
      'email': email,
      'verifiedEmail': verifiedEmail,
      'createdAt': createdAt.toString(),
    };
  }

  factory UserModel.newWith({
    String? id,
    bool? admin,
    String? name,
    String? surname,
    String? email,
    bool? verifiedEmail,
    String? cpf,
    DateTime? birthday,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? '',
      admin: admin ?? false,
      name: name ?? '',
      surname: surname ?? '',
      email: email ?? '',
      verifiedEmail: verifiedEmail ?? false,
      cpf: cpf ?? '',
      birthday: UserBirthday(
        day: '01',
        month: '01',
        year: (DateTime.now().year - 18).toString(),
      ),
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      admin: map['admin'] as bool,
      name: map['name'] as String,
      surname: map['surname'] as String,
      birthday: UserBirthday.fromMap(map['birthday'] as Map<String, dynamic>),
      cpf: map['cpf'] as String,
      email: map['email'] as String,
      verifiedEmail: map['verifiedEmail'] as bool,
      createdAt: DateTime.tryParse(map['createdAt']) ?? DateTime.now(),
    );
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      admin: entity.admin,
      name: entity.name,
      surname: entity.surname,
      birthday: entity.birthday,
      cpf: entity.cpf,
      email: entity.email,
      verifiedEmail: entity.verifiedEmail,
      createdAt: entity.createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, admin: $admin, name: $name, surname: $surname, birthday: $birthday, cpf: $cpf, email: $email, verifiedEmail: $verifiedEmail, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.admin == admin &&
        other.name == name &&
        other.surname == surname &&
        other.birthday == birthday &&
        other.cpf == cpf &&
        other.email == email &&
        other.verifiedEmail == verifiedEmail &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        admin.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        birthday.hashCode ^
        cpf.hashCode ^
        email.hashCode ^
        verifiedEmail.hashCode ^
        createdAt.hashCode;
  }
}
