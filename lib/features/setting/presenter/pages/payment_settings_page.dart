import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_settings_page_controller/payment_settings_page_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/widgets/installment_settings.dart';
import 'package:leechineo_panel/features/setting/presenter/widgets/payment_methods.dart';

class PaymentMethodsSettingsPage extends StatelessWidget {
  final PaymentSettingsPageController controller;
  const PaymentMethodsSettingsPage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controller.builder(
      builder: (context, data) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: controller.methods.isSaveButtonEnabled()
                ? controller.methods.savePaymentSettings
                : null,
            child: const Icon(Icons.save),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  PaymentMethods(
                    loading: data.loading || data.saving,
                    onPaymentMethodUpdated: (paymentMethodSettings) =>
                        controller.methods.onUpdated(
                      paymentMethodSettings: paymentMethodSettings,
                    ),
                    controler: controller.paymentMethodsControler,
                  ),
                  InstallmentSettingsWidget(
                    loading: data.loading || data.saving,
                    controller: controller.installmentSettingsController,
                    onInstallmentsUpdated: (installmentsSettings) =>
                        controller.methods.onUpdated(
                      installmentsSettings: installmentsSettings,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        );
      },
      allowAlertDialog: true,
      eventListener: (context, event, data) {
        if (event.id == 'payment_settings_saved') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Configurações de pagamento salvas.',
              ),
              action: SnackBarAction(
                label: 'Fechar',
                onPressed: () {},
              ),
            ),
          );
        }
      },
    );
  }
}
