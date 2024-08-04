import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/address/data/models/address_model.dart';
import 'package:leechineo_panel/features/address/domain/datasources/address_datasource.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

class AddressDatasourceImpl extends AppDatasource implements AddressDatasource {
  late final HttpAdapter _httpAdapter;

  AddressDatasourceImpl({
    required HttpAdapter httpAdapter,
  }) {
    _httpAdapter = httpAdapter;
  }

  @override
  Future<AddressEntity> getAddressByZipcode(String zipcode) async {
    final address = await exec<AddressEntity>(() async {
      final response = await _httpAdapter.get('/addresses/zipcode/$zipcode');
      final address = AddressModel.fromJson(response.data);
      return address;
    });
    return address;
  }

  @override
  Future<PaginatedResultOutput<AddressEntity>> getUserAddresses({
    required String userId,
    DataRequest? dataRequest,
  }) async {
    final paginatedAddresses = await exec<PaginatedResultOutput<AddressEntity>>(
      () async {
        final response = await _httpAdapter.get('/addresses/user/$userId');
        final paginatedAddresses = PaginatedResultOutput(
          items: (response.data['items'] as List)
              .map(
                (e) => AddressModel.fromJson(e),
              )
              .toList(),
          total: response.data['total'],
        );
        return paginatedAddresses;
      },
    );
    return paginatedAddresses;
  }
}
