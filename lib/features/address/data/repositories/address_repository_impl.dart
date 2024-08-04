import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/address/domain/datasources/address_datasource.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';
import 'package:leechineo_panel/features/address/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  late final AddressDatasource _addressDatasource;

  AddressRepositoryImpl({
    required AddressDatasource addressDatasource,
  }) {
    _addressDatasource = addressDatasource;
  }

  @override
  Future<AddressEntity> getAddressByZipcode(String zipcode) async {
    final address = await _addressDatasource.getAddressByZipcode(zipcode);
    return address;
  }

  @override
  Future<PaginatedResultOutput<AddressEntity>> getUserAddresses({
    required String userId,
    DataRequest? dataRequest,
  }) async {
    final addresses = await _addressDatasource.getUserAddresses(
      userId: userId,
      dataRequest: dataRequest,
    );
    return addresses;
  }
}
