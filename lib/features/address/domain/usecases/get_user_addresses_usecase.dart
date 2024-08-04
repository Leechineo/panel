import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';

abstract class GetUserAddressesUseCase {
  Future<PaginatedResultOutput<AddressEntity>> call({
    required String userId,
    DataRequest? dataRequest,
  });
}
