import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/domain/usecases/get_payment_settings_usecase.dart';
import 'package:leechineo_panel/features/setting/domain/usecases/save_payment_settings_usecase.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/installment_settings_controller/Installment_settings_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_methods_controller.dart/payment_methods_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_settings_page_controller/payment_settings_page_methods.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_settings_page_controller/payment_settings_page_data.dart';

class PaymentSettingsPageController
    extends AppController<PaymentSettingsPageData, PaymentSettingsPageMethods> {
  late final GetPaymentSettingsUseCase _getPaymentSettingsUseCase;
  late final SavePaymentSettingsUseCase _savePaymentSettingsUseCase;

  final PaymentMethodsControler paymentMethodsControler;
  final InstallmentSettingsController installmentSettingsController;

  PaymentSettingsPageController({
    super.events,
    required GetPaymentSettingsUseCase getPaymentSettingsUseCase,
    required SavePaymentSettingsUseCase savePaymentSettingsUseCase,
    required this.paymentMethodsControler,
    required this.installmentSettingsController,
  }) {
    _getPaymentSettingsUseCase = getPaymentSettingsUseCase;
    _savePaymentSettingsUseCase = savePaymentSettingsUseCase;
    methods.loadPaymentSettings();
  }

  @override
  PaymentSettingsPageData defineData() {
    return PaymentSettingsPageData(
      loading: true,
      saving: false,
      currentSettings: PaymentSettingsEntity(
        id: '',
        name: '',
        value: PaymentSettingsValue(
          paymentMethods: [],
          installments: InstallmentsSettings(
            enabled: false,
            installments: [],
          ),
        ),
        createdAt: DateTime.now(),
      ),
      orignalPaymentSettings: '',
    );
  }

  @override
  PaymentSettingsPageMethods defineMethods() {
    return PaymentSettingsPageMethods(
      savePaymentSettings: () async {
        updateData(
          data.copyWith(
            saving: true,
          ),
        );
        try {
          final updatedPaymentSettings = await _savePaymentSettingsUseCase(
            data.currentSettings,
          );
          updateData(
            data.copyWith(
              orignalPaymentSettings: updatedPaymentSettings.toString(),
            ),
          );
          dispatchEvent(
            AppControllerEvent(
              id: 'payment_settings_saved',
              data: data,
            ),
          );
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            saving: false,
          ),
        );
      },
      isSaveButtonEnabled: () {
        if (data.saving || data.loading) {
          return false;
        }
        return data.currentSettings.toString() !=
            data.orignalPaymentSettings.toString();
      },
      loadPaymentSettings: () async {
        updateData(
          data.copyWith(
            loading: true,
          ),
        );
        try {
          final paymentSettings = await _getPaymentSettingsUseCase();
          paymentMethodsControler.methods.definePaymentMethodsSettings(
            paymentSettings.value.paymentMethods,
          );
          installmentSettingsController.methods.defineInstallmentSettings(
            paymentSettings.value.installments,
          );
          updateData(
            data.copyWith(
              currentSettings: paymentSettings,
              orignalPaymentSettings: paymentSettings.toString(),
            ),
          );
        } catch (e) {
          catchError(e);
        }
        updateData(
          data.copyWith(
            loading: false,
          ),
        );
      },
      onUpdated: ({installmentsSettings, paymentMethodSettings}) {
        updateData(
          data.copyWith(
            currentSettings: PaymentSettingsEntity(
              id: data.currentSettings.id,
              name: data.currentSettings.name,
              value: PaymentSettingsValue(
                paymentMethods: paymentMethodSettings ??
                    data.currentSettings.value.paymentMethods,
                installments: installmentsSettings ??
                    data.currentSettings.value.installments,
              ),
              createdAt: data.currentSettings.createdAt,
            ),
          ),
        );
      },
    );
  }
}
