import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

abstract class AddressDatasource {
  Future<AddressEntity> getAddressByZipcode(String zipcode);
  Future<PaginatedResultOutput<AddressEntity>> getUserAddresses({
    required String userId,
    DataRequest? dataRequest,
  });
}
