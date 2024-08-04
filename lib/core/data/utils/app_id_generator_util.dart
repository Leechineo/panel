import 'package:uuid/uuid.dart';

class AppIdGenerator {
  static String gen({String? prefix, String? suffix}) {
    String idGenerated = const Uuid().v1();
    if (prefix != null) {
      idGenerated = prefix + idGenerated;
    }
    if (suffix != null) {
      idGenerated = idGenerated + suffix;
    }
    return idGenerated;
  }
}
