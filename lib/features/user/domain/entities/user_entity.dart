import 'dart:convert';

class UserBirthday {
  final String day;
  final String month;
  final String year;

  UserBirthday({
    required this.day,
    required this.month,
    required this.year,
  });

  UserBirthday copyWith({
    String? day,
    String? month,
    String? year,
  }) {
    return UserBirthday(
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'month': month,
      'year': year,
    };
  }

  DateTime toDate() {
    return DateTime(
      int.parse(year),
      int.parse(month),
      int.parse(day),
    );
  }

  factory UserBirthday.fromDate(DateTime date) {
    return UserBirthday(
      day: date.day.toString().padLeft(2, '0'),
      month: date.month.toString().padLeft(2, '0'),
      year: date.year.toString(),
    );
  }

  factory UserBirthday.fromMap(Map<String, dynamic> map) {
    return UserBirthday(
      day: map['day'] as String,
      month: map['month'] as String,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBirthday.fromJson(String source) =>
      UserBirthday.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserBirthday(day: $day, month: $month, year: $year)';

  @override
  bool operator ==(covariant UserBirthday other) {
    if (identical(this, other)) return true;

    return other.day == day && other.month == month && other.year == year;
  }

  @override
  int get hashCode => day.hashCode ^ month.hashCode ^ year.hashCode;
}

abstract class UserEntity {
  final String id;
  final bool admin;
  final String name;
  final String surname;
  final UserBirthday birthday;
  final String cpf;
  final String email;
  final bool verifiedEmail;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    this.admin = false,
    required this.name,
    required this.surname,
    required this.birthday,
    required this.cpf,
    required this.email,
    required this.verifiedEmail,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, admin: $admin, name: $name, surname: $surname, birthday: $birthday, cpf: $cpf, email: $email, verifiedEmail: $verifiedEmail, createdAt: $createdAt)';
  }
}
