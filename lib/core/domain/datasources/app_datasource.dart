import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/errors/app_error.dart';
import 'package:leechineo_panel/core/domain/errors/internal_error.dart';

abstract class AppDatasource {
  Future<T> exec<T>(
    Future<T> Function() callback, {
    Future<void> Function()? onCatch,
  }) async {
    try {
      final callbackData = await callback();
      return callbackData;
    } catch (e) {
      print(e);
      if (onCatch != null) {
        await onCatch();
      }
      if (e is HttpResponse) {
        throw AppError(
          code: e.statusCode,
          title: '',
          error: e.data['error'] ?? 'unknown_error',
          message: e.data['message'] ?? 'Erro desconhecido',
        );
      }
      if (e is AppError) {
        rethrow;
      }
      throw InternalError();
    }
  }
}
