import 'package:leechineo_panel/core/data/utils/app_id_generator_util.dart';
import 'package:leechineo_panel/features/product/domain/entities/product_entity.dart';

class ProductSpecificationModel implements ProductSpecification {
  @override
  final String id;
  @override
  final String title;
  @override
  final String value;

  ProductSpecificationModel({
    required this.id,
    required this.title,
    required this.value,
  });

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) {
    return ProductSpecificationModel(
      id: json['id'],
      title: json['title'],
      value: json['value'],
    );
  }

  ProductSpecificationModel copyWith({
    String? id,
    String? title,
    String? value,
  }) {
    return ProductSpecificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  factory ProductSpecificationModel.newWith({
    String? id,
    String? title,
    String? value,
  }) {
    return ProductSpecificationModel(
      id: id ?? AppIdGenerator.gen(prefix: 'specification-'),
      title: title ?? '',
      value: value ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'value': value,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
