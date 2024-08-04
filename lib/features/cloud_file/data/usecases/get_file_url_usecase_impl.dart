import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/features/cloud_file/domain/usecases/get_file_url_usecase.dart';

class GetFileUrlUseCaseImpl implements GetFileUrlUseCase {
  late final HttpAdapter _httpAdapter;
  GetFileUrlUseCaseImpl(HttpAdapter httpAdapter) {
    _httpAdapter = httpAdapter;
  }

  @override
  String call(String fileId) {
    return '${_httpAdapter.baseUrl}/files/$fileId';
  }
}
