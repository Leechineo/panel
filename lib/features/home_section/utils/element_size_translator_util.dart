import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/element_size.dart';

class ElementSizeTranslatorUtil {
  static double fromFixed(ElementSize size) {
    return size.value;
  }

  static double fromVirtalHeight(ElementSize size, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height * (size.value / 100);
    return height;
  }

  static double fromVirtualWidth(ElementSize size, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * (size.value / 100);
    return width;
  }

  static double? convertSize(ElementSize elementSize, BuildContext context) {
    double size = 0;
    if (elementSize.type == ElementSizeType.fixed) {
      size = elementSize.value;
    } else if (elementSize.type == ElementSizeType.virtualHeight) {
      size = ElementSizeTranslatorUtil.fromVirtalHeight(elementSize, context);
    } else if (elementSize.type == ElementSizeType.virtualWidth) {
      size = ElementSizeTranslatorUtil.fromVirtualWidth(elementSize, context);
    } else {
      size = -1;
    }
    if (size == -1) {
      return null;
    }
    return size;
  }
}
