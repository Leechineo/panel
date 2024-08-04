import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/domain/repositories/settings_repository.dart';
import 'package:leechineo_panel/features/setting/domain/usecases/save_payment_settings_usecase.dart';

class SavePaymentSettingsUseCaseImpl implements SavePaymentSettingsUseCase {
  final SettingsRepository _settingsRepository;

  SavePaymentSettingsUseCaseImpl({
    required SettingsRepository settingsRepository,
  }) : _settingsRepository = settingsRepository;

  @override
  Future<PaymentSettingsEntity> call(
    PaymentSettingsEntity paymentSettings,
  ) async {
    final updatedPaymentSettings =
        await _settingsRepository.savePaymentSettings(
      paymentSettings,
    );
    return updatedPaymentSettings;
  }
}
