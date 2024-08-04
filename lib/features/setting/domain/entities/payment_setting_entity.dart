// ignore_for_file: public_member_api_docs, sort_constructors_first
enum PaymentMethodName {
  pix,
  slip,
  creditCard,
}

class Installment {
  final int installmentValue;
  final double minPriceValue;
  final double interest;

  Installment({
    required this.installmentValue,
    required this.minPriceValue,
    required this.interest,
  });
}

class InstallmentsSettings {
  final bool enabled;
  final List<Installment> installments;

  InstallmentsSettings({
    required this.enabled,
    required this.installments,
  });
}

class PaymentMethodSettings {
  final PaymentMethodName name;
  final double discount;
  final bool enabled;

  PaymentMethodSettings({
    required this.name,
    required this.discount,
    required this.enabled,
  });

  String nameToString() {
    switch (name) {
      case PaymentMethodName.pix:
        return 'pix';
      case PaymentMethodName.slip:
        return 'Boleto';
      case PaymentMethodName.creditCard:
        return 'Cartão de crédito';
    }
  }

  @override
  String toString() =>
      'PaymentMethodSettings(name: $name, discount: $discount, enabled: $enabled)';
}

class PaymentSettingsValue {
  final List<PaymentMethodSettings> paymentMethods;
  final InstallmentsSettings installments;

  PaymentSettingsValue({
    required this.paymentMethods,
    required this.installments,
  });

  @override
  String toString() =>
      'PaymentSettingsValue(paymentMethods: $paymentMethods, installments: $installments)';
}

class PaymentSettingsEntity {
  final String id;
  final String name;
  final PaymentSettingsValue value;
  final DateTime createdAt;

  PaymentSettingsEntity({
    required this.id,
    required this.name,
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'PaymentSettingsEntity(id: $id, name: $name, value: $value, createdAt: $createdAt)';
  }
}
