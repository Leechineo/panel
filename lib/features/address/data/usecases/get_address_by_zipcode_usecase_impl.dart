import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';
import 'package:leechineo_panel/features/address/domain/repositories/address_repository.dart';
import 'package:leechineo_panel/features/address/domain/usecases/get_address_by_zipcode_usecase.dart';

class GetAddressByZipcodeUseCaseImpl implements GetAddressByZipcodeUseCase {
  late final AddressRepository _addressRepository;

  GetAddressByZipcodeUseCaseImpl({
    required AddressRepository addressRepository,
  }) {
    _addressRepository = addressRepository;
  }

  @override
  Future<AddressEntity> call(String zipcode) async {
    final address = await _addressRepository.getAddressByZipcode(zipcode);
    return address;
  }
}
