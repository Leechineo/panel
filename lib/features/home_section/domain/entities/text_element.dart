// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

enum TextElementFontStyle {
  italic,
  normal,
}

enum TextElementDecorarion {
  none,
  underline,
  overline,
  lineThrough,
}

enum TextElementDecorationStyle {
  solid,
  double,
  dotted,
  dashed,
  wavy,
}

enum TextElementAlign {
  left,
  right,
  center,
  justify,
  start,
  end,
}

class TextElementStyle {
  double fontSize;
  int fontWeight;
  TextElementFontStyle fontStyle;
  String? color;
  double letterSpacing;
  double wordSpacing;
  double lineHeight;
  TextElementDecorarion decorarion;
  String? decorationColor;
  TextElementAlign align;
  TextElementDecorationStyle decorationStyle;
  TextElementStyle({
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
    required this.color,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.lineHeight,
    required this.decorarion,
    required this.decorationColor,
    required this.align,
    required this.decorationStyle,
  });

  Map<String, dynamic> toMap() {
    return {
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'fontStyle': fontStyle.name,
      'color': color,
      'letterSpacing': letterSpacing,
      'wordSpacing': wordSpacing,
      'lineHeight': lineHeight,
      'decorarion': decorarion.name,
      'decorationColor': decorationColor,
      'align': align.name,
      'decorationStyle': decorationStyle.name,
    };
  }
}

class ResponsivinessTextOptions extends ResponsivinessItem {
  ElementDisplay display;
  TextElementStyle style;

  ResponsivinessTextOptions({
    required this.display,
    required this.style,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'display': display.name,
      'style': style.toMap(),
    };
  }
}

class TextElement extends Element {
  @override
  final String id;
  @override
  final Responsiviness<ResponsivinessTextOptions> responsiviness;
  final ElementColor color;
  String content;

  TextElement({
    required this.id,
    required this.responsiviness,
    required this.color,
    required this.content,
  });

  @override
  String toString() =>
      'TextElement(responsiviness: $responsiviness, color: $color, content: $content)';

  @override
  Map<String, dynamic> toMap() {
    TextElement(
      id: id,
      responsiviness: responsiviness,
      color: color,
      content: content,
    );
    return {
      'id': id,
      'responsiviness': responsiviness.toMap(),
      'color': color.toMap(),
      'content': content,
    };
  }
}
