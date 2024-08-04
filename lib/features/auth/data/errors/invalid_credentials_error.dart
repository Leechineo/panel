import 'package:leechineo_panel/core/domain/errors/app_error.dart';

class InvalidCredentialsError implements AppError {
  @override
  int get code => 400;

  @override
  String get error => 'auth.invalid_credentials';

  @override
  String get message => 'Os dados informados não são válidos.';

  @override
  String get title => 'Erro ao autenticar';
}
