// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields
import 'dart:convert';

import 'package:leechineo_panel/features/home_section/domain/entities/element_size.dart';

enum Elements {
  row,
  column,
  container,
  image,
  text,
  link,
}

abstract class Element {
  String get id;
  Element? child;
  List<Element>? children;
  Responsiviness? responsiviness;

  Map<String, dynamic> toMap();
}

enum ElementScreenSizes {
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
}

enum ElementAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly,
}

enum ElementAlignmentType {
  justify,
  align,
}

enum ElementDisplay {
  show,
  hidden;

  static fromString(String value) {
    switch (value) {
      case 'show':
        return ElementDisplay.show;
      case 'hidden':
        return ElementDisplay.hidden;
      default:
        return ElementDisplay.show;
    }
  }
}

enum ElementOverflow {
  block,
  scroll,
  wrap;

  static fromString(String value) {
    switch (value) {
      case 'block':
        return ElementOverflow.block;
      case 'scroll':
        return ElementOverflow.scroll;
      case 'wrap':
        return ElementOverflow.wrap;
      default:
        return ElementOverflow.block;
    }
  }
}

class ElementBorderRadius {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  ElementBorderRadius({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  @override
  String toString() {
    return 'ElementBorderRadius(topLeft: $topLeft, topRight: $topRight, bottomLeft: $bottomLeft, bottomRight: $bottomRight)';
  }
}

class ElementColor {
  final String light;
  final String dark;

  ElementColor({
    required this.light,
    required this.dark,
  });

  @override
  String toString() => 'ElementColor(light: $light, dark: $dark)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'light': light,
      'dark': dark,
    };
  }

  factory ElementColor.fromMap(Map<String, dynamic> map) {
    return ElementColor(
      light: map['light'] as String,
      dark: map['dark'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ElementColor.fromJson(String source) =>
      ElementColor.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class ResponsivinessItem {
  Map<String, dynamic> toMap();
}

class Responsiviness<T extends ResponsivinessItem> {
  final T xs;
  final T sm;
  final T md;
  final T lg;
  final T xl;
  final T xxl;
  bool linked;

  Responsiviness({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.linked,
  });

  Responsiviness<T> copyWith({
    T? xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
    bool? linked,
  }) {
    return Responsiviness<T>(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      linked: linked ?? this.linked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'xs': xs.toMap(),
      'sm': sm.toMap(),
      'md': md.toMap(),
      'lg': lg.toMap(),
      'xl': xl.toMap(),
      'xxl': xxl.toMap(),
      'linked': linked,
    };
  }

  @override
  String toString() {
    return 'Responsiviness(xs: $xs, sm: $sm, md: $md, lg: $lg, xl: $xl, xxl: $xxl)';
  }
}

class ResponsivinessImageOptions extends ResponsivinessItem {
  final ElementSize width;
  final ElementSize height;
  final int blurLevel;

  ResponsivinessImageOptions({
    required this.width,
    required this.height,
    required this.blurLevel,
  });

  @override
  String toString() =>
      'ResponsivinessImageOptions(width: $width, height: $height, blurLevel: $blurLevel)';

  @override
  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
      'blurLevel': blurLevel,
    };
  }
}

class ImageElement extends Element {
  @override
  final String id;
  String? fileId;
  @override
  final Responsiviness<ResponsivinessImageOptions> responsiviness;
  @override
  final Element? child;

  ImageElement({
    required this.id,
    required this.fileId,
    required this.responsiviness,
    required this.child,
  });

  @override
  String toString() =>
      'ImageElement(fileId: $fileId, responsiviness: $responsiviness, child: $child)';

  @override
  Map<String, dynamic> toMap() {
    return {
      'elementType': 'image',
      'id': id,
      'fileId': fileId,
      'responsiviness': responsiviness.toMap(),
      if (child != null) 'child': child!.toMap(),
    };
  }
}

class ResponsivinessFlexOptions extends ResponsivinessItem {
  ElementDisplay display;
  ElementAlignment align;
  ElementAlignment justify;

  ResponsivinessFlexOptions({
    required this.display,
    required this.align,
    required this.justify,
  });

  @override
  String toString() {
    return 'ResponsivinessFlexOptions(display: $display, align: $align, justify: $justify)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'display': display.name,
      'align': align.name,
      'justify': justify.name,
    };
  }
}

class RowElement extends Element {
  @override
  final String id;
  @override
  final Responsiviness<ResponsivinessFlexOptions> responsiviness;
  @override
  final List<Element> children;

  RowElement({
    required this.id,
    required this.responsiviness,
    required this.children,
  });

  @override
  String toString() =>
      'RowElement(id: $id, responsiviness: $responsiviness, children: $children)';

  @override
  Map<String, dynamic> toMap() {
    return {
      'elementType': 'row',
      'id': id,
      'responsiviness': responsiviness.toMap(),
      'children': children.map((element) => element.toMap()).toList(),
    };
  }
}

class ColumnElement extends Element {
  @override
  final String id;
  @override
  final Responsiviness<ResponsivinessFlexOptions> responsiviness;
  @override
  final List<Element> children;

  ColumnElement({
    required this.id,
    required this.responsiviness,
    required this.children,
  });

  @override
  String toString() =>
      'ColumnElement(responsiviness: $responsiviness, children: $children)';

  @override
  Map<String, dynamic> toMap() {
    return {
      'elementType': 'column',
      'id': id,
      'responsiviness': responsiviness.toMap(),
      'children': children.map((element) => element.toMap()).toList(),
    };
  }
}

class ReponsivinessSectionOptions extends ResponsivinessItem {
  final ElementDisplay display;

  ReponsivinessSectionOptions({
    required this.display,
  });

  @override
  String toString() => 'ReponsivinessSectionOptions(display: $display)';

  @override
  Map<String, dynamic> toMap() {
    return {
      'display': display.name,
    };
  }
}

class SectionEntity {
  final String id;
  final String? user;
  Responsiviness<ReponsivinessSectionOptions> responsiviness;
  List<Element> elements;
  final DateTime createdAt;

  SectionEntity({
    required this.id,
    this.user,
    required this.responsiviness,
    required this.elements,
    required this.createdAt,
  });

  SectionEntity copyWith({
    String? id,
    String? user,
    bool? linked,
    Responsiviness<ReponsivinessSectionOptions>? responsiviness,
    List<Element>? elements,
    DateTime? createdAt,
  }) {
    return SectionEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      responsiviness: responsiviness ?? this.responsiviness,
      elements: elements ?? this.elements,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'responsiviness': responsiviness.toMap(),
      'elements': elements
          .map(
            (element) => element.toMap(),
          )
          .toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SectionEntity(id: $id, user: $user, responsiviness: $responsiviness, elements: $elements, createdAt: $createdAt)';
  }
}
