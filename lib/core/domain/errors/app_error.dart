class AppError implements Exception {
  final int code;
  final String error;
  final String title;
  final String message;

  AppError({
    required this.code,
    required this.error,
    required this.title,
    required this.message,
  });

  @override
  String toString() {
    return 'error: $error, message: $message, code: $code';
  }
}
