// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: overridden_fields
import 'dart:convert';

import 'package:leechineo_panel/features/home_section/domain/entities/element_size.dart';
import 'package:leechineo_panel/features/home_section/domain/entities/section_entity.dart';

enum ElementSpacingType {
  only,
  all,
  symetric;

  static fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'only':
        return ElementSpacingType.only;
      case 'all':
        return ElementSpacingType.all;
      case 'symetric':
        return ElementSpacingType.symetric;
    }
  }
}

class ElementSpacing {
  ElementSpacingType type;
  String value;

  ElementSpacing({required this.type, required this.value});

  static ElementSpacing only({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    final value = '${top ?? 0} ${bottom ?? 0} ${left ?? 0} ${right ?? 0}';
    return ElementSpacing(
      type: ElementSpacingType.only,
      value: value,
    );
  }

  static ElementSpacing all(double value) {
    return ElementSpacing(
      type: ElementSpacingType.all,
      value: '$all $all $all $all',
    );
  }

  static ElementSpacing symetric({
    double? vertical,
    double? horizontal,
  }) {
    final value = '$vertical $vertical $horizontal $horizontal';
    return ElementSpacing(
      type: ElementSpacingType.symetric,
      value: value,
    );
  }

  static ElementSpacing zero() {
    return ElementSpacing(
      type: ElementSpacingType.all,
      value: '0 0 0 0',
    );
  }

  double getTop() {
    return double.parse(value.split(' ')[0]);
  }

  double getBottom() {
    final splittedValue = value.split(' ');
    return double.parse(splittedValue[1]);
  }

  double getLeft() {
    final splittedValue = value.split(' ');
    return double.parse(splittedValue[2]);
  }

  double getRight() {
    final splittedValue = value.split(' ');
    return double.parse(splittedValue[3]);
  }

  double getVertical() {
    final splittedValue = value.split(' ');
    return double.parse(splittedValue[0]);
  }

  double getHorizontal() {
    final splittedValue = value.split(' ');
    return double.parse(splittedValue[2]);
  }

  double getAll() {
    final splittedValue = value.split(' ');
    return double.parse(splittedValue[0]);
  }

  void setTop(double value) {
    final splittedValue = this.value.split(' ');
    splittedValue[0] = '$value';
    this.value = splittedValue.join(' ');
  }

  void setBottom(double value) {
    final splittedValue = this.value.split(' ');
    splittedValue[1] = '$value';
    this.value = splittedValue.join(' ');
  }

  void setLeft(double value) {
    final splittedValue = this.value.split(' ');
    splittedValue[2] = '$value';
    this.value = splittedValue.join(' ');
  }

  void setRight(double value) {
    final splittedValue = this.value.split(' ');
    splittedValue[3] = '$value';
    this.value = splittedValue.join(' ');
  }

  void setAll(double value) {
    setTop(value);
    setBottom(value);
    setLeft(value);
    setRight(value);
  }

  void setVertical(double value) {
    setTop(value);
    setBottom(value);
  }

  void setHorizontal(double value) {
    setLeft(value);
    setBottom(value);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
    };
  }

  factory ElementSpacing.fromMap(Map<String, dynamic> map) {
    return ElementSpacing(
      type: ElementSpacingType.fromMap(map['type']),
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ElementSpacing.fromJson(String source) =>
      ElementSpacing.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ResponsivinessContainerOptions extends ResponsivinessItem {
  final ElementSize width;
  final ElementSize height;
  final ElementSpacing padding;
  final ElementSpacing margin;
  final ElementDisplay display;
  final ElementOverflow overflow;

  ResponsivinessContainerOptions({
    required this.width,
    required this.height,
    required this.display,
    required this.margin,
    required this.padding,
    required this.overflow,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'width': width.toMap(),
      'height': height.toMap(),
      'display': display.name,
      'margin': margin.toMap(),
      'padding': padding.toMap(),
      'overflow': overflow.name,
    };
  }
}

class ContainerElement extends Element {
  @override
  final String id;
  @override
  final Responsiviness<ResponsivinessContainerOptions> responsiviness;
  final ElementColor color;
  @override
  Element? child;

  ContainerElement({
    required this.id,
    required this.responsiviness,
    required this.color,
    required this.child,
  });

  @override
  String toString() =>
      'ContainerElement(responsiviness: $responsiviness, color: $color, child: $child)';

  @override
  Map<String, dynamic> toMap() {
    return {
      'elementType': 'container',
      'id': id,
      'responsiviness': responsiviness.toMap(),
      'color': color.toMap(),
      'child': child?.toMap(),
    };
  }
}
