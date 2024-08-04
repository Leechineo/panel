import 'package:leechineo_panel/core/domain/errors/app_error.dart';

class InvalidFilesError implements AppError {
  @override
  int get code => 500;

  @override
  String get error => 'cloud_file.invalid_files';

  @override
  String get message => 'Os arquivos são invalidos';

  @override
  String get title => 'Erro ao carregar arquivos';
}
