import 'package:leechineo_panel/features/setting/domain/datasources/settings_datasource.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource _settingsDatasource;

  SettingsRepositoryImpl({
    required SettingsDatasource settingsDatasource,
  }) : _settingsDatasource = settingsDatasource;

  @override
  Future<PaymentSettingsEntity> getPaymentSettings({
    required bool refresh,
  }) async {
    final paymentSettings = await _settingsDatasource.getPaymentSettings(
      refresh: refresh,
    );
    return paymentSettings;
  }

  @override
  Future<PaymentSettingsEntity> savePaymentSettings(
    PaymentSettingsEntity paymentSettings,
  ) async {
    final updatedSettings = await _settingsDatasource.savePaymentSettings(
      paymentSettings,
    );
    return updatedSettings;
  }
}
