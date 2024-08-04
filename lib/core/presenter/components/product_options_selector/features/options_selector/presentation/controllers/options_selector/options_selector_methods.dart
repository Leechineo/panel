import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';

class OptionsSelectorMethods {
  final Future<void> Function({DataRequest? dataRequest}) loadProducts;
  OptionsSelectorMethods({
    required this.loadProducts,
  });
}
