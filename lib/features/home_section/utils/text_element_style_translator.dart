import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/data/utils/color_utils.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/text_element.dart';

FontWeight _fontWeightTranslator(int fontWeight) {
  switch (fontWeight) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;
    default:
      return FontWeight.normal;
  }
}

FontStyle _fontStyleTranslator(TextElementFontStyle fontStyle) {
  switch (fontStyle) {
    case TextElementFontStyle.italic:
      return FontStyle.italic;
    case TextElementFontStyle.normal:
      return FontStyle.normal;
  }
}

TextDecoration _textDecorationTranslator(TextElementDecorarion decorarion) {
  switch (decorarion) {
    case TextElementDecorarion.none:
      return TextDecoration.none;
    case TextElementDecorarion.underline:
      return TextDecoration.underline;
    case TextElementDecorarion.overline:
      return TextDecoration.overline;
    case TextElementDecorarion.lineThrough:
      return TextDecoration.lineThrough;
  }
}

TextDecorationStyle _decorationStyleTranslator(
    TextElementDecorationStyle decorationStyle) {
  switch (decorationStyle) {
    case TextElementDecorationStyle.solid:
      return TextDecorationStyle.solid;
    case TextElementDecorationStyle.double:
      return TextDecorationStyle.double;
    case TextElementDecorationStyle.dotted:
      return TextDecorationStyle.dotted;
    case TextElementDecorationStyle.dashed:
      return TextDecorationStyle.dashed;
    case TextElementDecorationStyle.wavy:
      return TextDecorationStyle.wavy;
  }
}

TextAlign textAlignTranslator(TextElementAlign align) {
  switch (align) {
    case TextElementAlign.start:
      return TextAlign.start;
    case TextElementAlign.left:
      return TextAlign.left;
    case TextElementAlign.right:
      return TextAlign.right;
    case TextElementAlign.center:
      return TextAlign.center;
    case TextElementAlign.justify:
      return TextAlign.justify;
    case TextElementAlign.end:
      return TextAlign.end;
  }
}

TextStyle textElementStyleTranslator(TextElementStyle textElementStyle) {
  return TextStyle(
    fontSize: textElementStyle.fontSize,
    fontWeight: _fontWeightTranslator(
      textElementStyle.fontWeight,
    ),
    fontStyle: _fontStyleTranslator(textElementStyle.fontStyle),
    color: textElementStyle.color != null
        ? ColorUtils.hexToColor(textElementStyle.color!)
        : null,
    letterSpacing: textElementStyle.letterSpacing,
    wordSpacing: textElementStyle.wordSpacing,
    height: textElementStyle.lineHeight,
    decoration: _textDecorationTranslator(textElementStyle.decorarion),
    decorationColor: textElementStyle.decorationColor != null
        ? ColorUtils.hexToColor(textElementStyle.decorationColor!)
        : null,
    decorationStyle:
        _decorationStyleTranslator(textElementStyle.decorationStyle),
  );
}
