import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage {
  static Widget svgNetwork(String url, {double? width, double? height}) {
    if (url.isNotEmpty) {
      return SvgPicture.network(
        url,
        width: width,
        height: height,
      );
    } else {
      return Container();
    }
  }
}
