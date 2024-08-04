import 'dart:ui';

class ColorUtils {
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}';
  }

  static Color hexToColor(String hexString) {
    String formattedString = hexString.replaceAll('#', '');

    if (formattedString.length != 6 && formattedString.length != 8) {
      throw ArgumentError("O código hexadecimal deve ter 6 ou 8 caracteres");
    }

    if (formattedString.length == 6) {
      formattedString = 'FF$formattedString';
    }

    int colorValue = int.parse(formattedString, radix: 16);
    return Color(colorValue);
  }
}
