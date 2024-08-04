import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/container_element.dart';

class ElementSpacingTranslatorUtil {
  EdgeInsetsGeometry all(ElementSpacing spacing) {
    final splittedValue = spacing.value.split(' ');
    return EdgeInsets.all(double.parse(splittedValue[0]));
  }

  EdgeInsetsGeometry only(ElementSpacing spacing) {
    final splittedValue = spacing.value.split(' ');
    return EdgeInsets.only(
      top: double.parse(splittedValue[0]),
      bottom: double.parse(splittedValue[1]),
      left: double.parse(splittedValue[2]),
      right: double.parse(splittedValue[3]),
    );
  }

  EdgeInsetsGeometry symetric(ElementSpacing spacing) {
    final splittedValue = spacing.value.split(' ');
    return EdgeInsets.symmetric(
      vertical: double.parse(splittedValue[0]),
      horizontal: double.parse(splittedValue[2]),
    );
  }

  static EdgeInsetsGeometry parse(ElementSpacing spacing) {
    final conversor = ElementSpacingTranslatorUtil();
    switch (spacing.type) {
      case ElementSpacingType.only:
        return conversor.only(spacing);
      case ElementSpacingType.all:
        return conversor.all(spacing);
      case ElementSpacingType.symetric:
        return conversor.symetric(spacing);
    }
  }
}
