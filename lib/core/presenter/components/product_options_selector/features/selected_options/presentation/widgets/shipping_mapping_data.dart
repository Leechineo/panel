import 'package:flutter/widgets.dart';
import 'package:leechineo_panel/core/domain/enums/currency_enum.dart';
import 'package:leechineo_panel/core/presenter/components/product_options_selector/domain/entities/option_shipping_entitiy.dart';

class ShippingMappingData extends StatelessWidget {
  final OptionShippingEntity? shippingMapping;
  const ShippingMappingData({required this.shippingMapping, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Estimativa:'),
            Text(
              'De ${shippingMapping?.shippingMethodMapping.arriveTime.min} à ${shippingMapping?.shippingMethodMapping.arriveTime.max} dias',
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Preço:'),
            Builder(
              builder: (context) {
                final currency =
                    shippingMapping?.shippingMethodMapping.price.currency ==
                            CurrencyEnum.brl
                        ? 'R\$'
                        : '\$';
                return Text(
                  '$currency${shippingMapping?.shippingMethodMapping.price.value.toStringAsFixed(2).replaceAll('.', ',')}',
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
