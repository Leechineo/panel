import 'package:leechineo_panel/core/domain/adapters/http_adapter.dart';
import 'package:leechineo_panel/core/domain/datasources/app_datasource.dart';
import 'package:leechineo_panel/features/setting/data/models/installment_model.dart';
import 'package:leechineo_panel/features/setting/data/models/installments_settings_model.dart';
import 'package:leechineo_panel/features/setting/data/models/payment_method_settings_model.dart';
import 'package:leechineo_panel/features/setting/data/models/payment_settings_model.dart';
import 'package:leechineo_panel/features/setting/data/models/payment_settings_value_model.dart';
import 'package:leechineo_panel/features/setting/domain/datasources/settings_datasource.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';

class SettingsDatasourceImpl extends AppDatasource
    implements SettingsDatasource {
  final HttpAdapter _httpAdapter;

  SettingsDatasourceImpl({required HttpAdapter httpAdapter})
      : _httpAdapter = httpAdapter;

  @override
  Future<PaymentSettingsEntity> getPaymentSettings({
    required bool refresh,
  }) async {
    return exec<PaymentSettingsEntity>(() async {
      final response = await _httpAdapter.get('/settings/payment');
      return PaymentSettingsModel.fromMap(response.data);
    });
  }

  @override
  Future<PaymentSettingsEntity> savePaymentSettings(
    PaymentSettingsEntity paymentSettings,
  ) {
    return exec<PaymentSettingsEntity>(() async {
      final paymentSettingsMap = PaymentSettingsModel(
        createdAt: paymentSettings.createdAt,
        id: paymentSettings.id,
        name: paymentSettings.name,
        value: PaymentSettingsValueModel(
          installments: InstallmentsSettingsModel(
            enabled: paymentSettings.value.installments.enabled,
            installments: paymentSettings.value.installments.installments
                .map(
                  (e) => InstallmentModel(
                    installmentValue: e.installmentValue,
                    interest: e.interest,
                    minPriceValue: e.minPriceValue,
                  ),
                )
                .toList(),
          ),
          paymentMethods: paymentSettings.value.paymentMethods
              .map(
                (e) => PaymentMethodSettingsModel(
                  enabled: e.enabled,
                  name: e.name,
                  discount: e.discount,
                ),
              )
              .toList(),
        ),
      ).toMap();
      final response = await _httpAdapter.patch(
        '/settings/payment',
        data: paymentSettingsMap,
      );
      final updatedPaymentSettings = PaymentSettingsModel.fromMap(
        response.data,
      );
      return updatedPaymentSettings;
    });
  }
}
