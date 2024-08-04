import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';

class OrderPayment extends StatelessWidget {
  const OrderPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      titleText: 'Pagamento',
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            DropdownButtonFormField(
              items: const [],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: 'Status do pagamento',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 12,
            ),
            DropdownButtonFormField(
              items: const [],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: 'Método de pagamento',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 12,
            ),
            DropdownButtonFormField(
              items: const [],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                labelText: 'Método de pagamento',
              ),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
