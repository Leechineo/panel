// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum ElementSizeType {
  fixed,
  percent,
  virtualHeight,
  virtualWidth,
}

class ElementSize {
  ElementSizeType type;
  double value;

  ElementSize({required this.type, required this.value});

  static ElementSize fixed(double value) {
    return ElementSize(
      type: ElementSizeType.fixed,
      value: value,
    );
  }

  static ElementSize percent(double value) {
    return ElementSize(
      type: ElementSizeType.percent,
      value: value,
    );
  }

  static ElementSize virtualHeight(double value) {
    return ElementSize(
      type: ElementSizeType.virtualHeight,
      value: value,
    );
  }

  static ElementSize virtualWidth(double value) {
    return ElementSize(
      type: ElementSizeType.virtualWidth,
      value: value,
    );
  }

  static ElementSize noSet() {
    return ElementSize(
      type: ElementSizeType.fixed,
      value: -1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'value': value,
    };
  }

  factory ElementSize.fromMap(Map<String, dynamic> map) {
    late final ElementSizeType type;
    switch (map['type']) {
      case 'fixed':
        type = ElementSizeType.fixed;
        break;
      case 'percent':
        type = ElementSizeType.percent;
        break;
      case 'virtualHeight':
        type = ElementSizeType.virtualHeight;
        break;
      case 'virtualWidth':
        type = ElementSizeType.virtualWidth;
        break;
      default:
        type = ElementSizeType.fixed;
        break;
    }

    return ElementSize(
      type: type,
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ElementSize.fromJson(String source) =>
      ElementSize.fromMap(json.decode(source) as Map<String, dynamic>);
}
