import 'package:leechineo_panel/features/shipping_method/domain/entities/shipping_method_entity.dart';

abstract class GetAllShippingMethodsUseCase {
  Future<List<ShippingMethodEntity>> call({bool refresh = false});
}
