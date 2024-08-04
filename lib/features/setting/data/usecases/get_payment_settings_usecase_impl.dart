import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/domain/repositories/settings_repository.dart';
import 'package:leechineo_panel/features/setting/domain/usecases/get_payment_settings_usecase.dart';

class GetPaymentSettingsUseCaseImpl implements GetPaymentSettingsUseCase {
  final SettingsRepository _settingsRepository;

  GetPaymentSettingsUseCaseImpl({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<PaymentSettingsEntity> call({bool? refresh}) async {
    final paymentSettings = await _settingsRepository.getPaymentSettings(
      refresh: refresh ?? false,
    );
    return paymentSettings;
  }
}
