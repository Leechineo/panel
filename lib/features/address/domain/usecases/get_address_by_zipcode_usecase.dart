import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

abstract class GetAddressByZipcodeUseCase {
  Future<AddressEntity> call(String zipcode);
}
