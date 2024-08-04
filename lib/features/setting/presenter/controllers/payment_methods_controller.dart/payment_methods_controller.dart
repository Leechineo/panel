import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/controllers/app_controller.dart';
import 'package:leechineo_panel/features/setting/domain/entities/payment_setting_entity.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_methods_controller.dart/payment_methods_data.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_methods_controller.dart/payment_methods_methods.dart';

class PaymentMethodsControler
    extends AppController<PaymentMethodsData, PaymentMethodsMethods> {
  PaymentMethodsControler();
  @override
  PaymentMethodsData defineData() {
    return PaymentMethodsData(
      paymentMethods: [
        ControllerPaymentMethodSetting(
          name: PaymentMethodName.pix,
          discount: 0,
          enabled: false,
          discountInputController: TextEditingController(
            text: '0,00',
          ),
        ),
        ControllerPaymentMethodSetting(
          name: PaymentMethodName.slip,
          discount: 0,
          enabled: false,
          discountInputController: TextEditingController(
            text: '0,00',
          ),
        ),
        ControllerPaymentMethodSetting(
          name: PaymentMethodName.creditCard,
          discount: 0,
          enabled: false,
          discountInputController: TextEditingController(
            text: '0,00',
          ),
        )
      ],
    );
  }

  @override
  PaymentMethodsMethods defineMethods() {
    return PaymentMethodsMethods(
      definePaymentMethodsSettings: (paymentMethodSettings) {
        updateData(
          data.copyWith(
            paymentMethods: paymentMethodSettings
                .map(
                  (e) => ControllerPaymentMethodSetting(
                    name: e.name,
                    discount: e.discount,
                    enabled: e.enabled,
                    discountInputController: TextEditingController(
                      text: e.discount.toStringAsFixed(2).replaceAll('.', ','),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
      updateDiscount: (paymentMethodName, value) {
        late final double? updatedDiscountParsed;
        if (value.isEmpty) {
          updatedDiscountParsed = 0;
        } else {
          updatedDiscountParsed = double.tryParse(
            value.replaceAll(',', '.'),
          );
        }
        final paymentMethodsFiltered = data.paymentMethods.where(
          (element) => element.name == paymentMethodName,
        );
        final paymentMethodExist = paymentMethodsFiltered.isNotEmpty;

        if (paymentMethodExist) {
          final paymentMethod = paymentMethodsFiltered.first;
          final updatedPaymentMethod = ControllerPaymentMethodSetting(
            name: paymentMethod.name,
            discount: updatedDiscountParsed ?? 0,
            enabled: paymentMethod.enabled,
            discountInputController: paymentMethod.discountInputController,
          );
          final paymentMethodIndex = data.paymentMethods.indexOf(paymentMethod);
          final paymentMethods = data.paymentMethods;
          paymentMethods[paymentMethodIndex] = updatedPaymentMethod;
          updateData(
            data.copyWith(
              paymentMethods: paymentMethods,
            ),
          );
        }
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_payment_method',
            data: data,
          ),
        );
      },
      updateEnabledStatus: (paymentMethodName, {enabled}) {
        final paymentMethodsFiltered = data.paymentMethods.where(
          (element) => element.name == paymentMethodName,
        );
        final paymentMethodExist = paymentMethodsFiltered.isNotEmpty;

        if (paymentMethodExist) {
          final paymentMethod = paymentMethodsFiltered.first;
          final updatedPaymentMethod = ControllerPaymentMethodSetting(
            name: paymentMethod.name,
            discount: paymentMethod.discount,
            enabled: enabled ?? !paymentMethod.enabled,
            discountInputController: paymentMethod.discountInputController,
          );
          final paymentMethodIndex = data.paymentMethods.indexOf(paymentMethod);
          final paymentMethods = data.paymentMethods;
          paymentMethods[paymentMethodIndex] = updatedPaymentMethod;
          updateData(
            data.copyWith(
              paymentMethods: paymentMethods,
            ),
          );
        }
        dispatchEvent(
          AppControllerEvent(
            id: 'updated_payment_method',
            data: data,
          ),
        );
      },
    );
  }
}
