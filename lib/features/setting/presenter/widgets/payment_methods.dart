import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_flex.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_methods_controller.dart/payment_methods_controller.dart';

class PaymentMethods extends StatelessWidget {
  final PaymentMethodsControler controler;
  final bool loading;
  final void Function(
    List<PaymentMethodSettings> paymentMethodSettings,
  ) onPaymentMethodUpdated;
  const PaymentMethods({
    required this.controler,
    required this.loading,
    required this.onPaymentMethodUpdated,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return controler.builder(
      builder: (context, data) {
        return AppCard(
          titleText: 'Métodos de pagamento',
          child: AppFlex(
            maxItemsPerRowSm: 1,
            maxItemsPerRowMd: 3,
            children: data.paymentMethods
                .map(
                  (paymentMethod) => Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          enabled: !loading,
                          value: paymentMethod.enabled,
                          onChanged: (value) =>
                              controler.methods.updateEnabledStatus(
                            paymentMethod.name,
                            enabled: value,
                          ),
                          title: Text(
                            paymentMethod.nameToString(),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        TextField(
                          enabled: !loading,
                          onChanged: (value) =>
                              controler.methods.updateDiscount(
                            paymentMethod.name,
                            value,
                          ),
                          controller: paymentMethod.discountInputController,
                          onTapOutside: (event) =>
                              paymentMethod.discountInputController.text =
                                  paymentMethod.discount
                                      .toStringAsFixed(2)
                                      .replaceAll('.', ','),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            labelText: 'Desconto',
                            suffixText: '%',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
      eventListener: (context, event, data) {
        if (event.id == 'updated_payment_method') {
          onPaymentMethodUpdated(data.paymentMethods);
        }
      },
    );
  }
}
