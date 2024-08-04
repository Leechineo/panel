import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/order/presenter/controllers/orders_page/orders_page_controller.dart';

class OrdersPage extends StatelessWidget {
  final OrdersPageController controller;
  const OrdersPage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppIlustration(
              AppIlustrations.orderDelivered,
              width: 200,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Nenhum pedido feito',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.methods.goToOrderEditor('null'),
        tooltip: 'Criar pedido',
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }
}
