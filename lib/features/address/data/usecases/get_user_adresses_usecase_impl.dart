import 'package:leechineo_panel/core/domain/entities/data_request_entity.dart';
import 'package:leechineo_panel/core/domain/entities/pagination_entity.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';
import 'package:leechineo_panel/features/address/domain/repositories/address_repository.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_user_addresses_usecase.dart';

class GetUserAddressesUseCaseImpl implements GetUserAddressesUseCase {
  late final AddressRepository _addressRepository;

  GetUserAddressesUseCaseImpl({
    required AddressRepository addressRepository,
  }) {
    _addressRepository = addressRepository;
  }

  @override
  Future<PaginatedResultOutput<AddressEntity>> call({
    required String userId,
    DataRequest? dataRequest,
  }) async {
    final paginatedAddresses = await _addressRepository.getUserAddresses(
      userId: userId,
      dataRequest: dataRequest,
    );
    return paginatedAddresses;
  }
}
