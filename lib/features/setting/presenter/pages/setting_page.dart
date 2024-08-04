import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/setting/presenter/controllers/payment_settings_page_controller/payment_settings_page_controller.dart';
import 'package:leechineo_panel/features/setting/presenter/pages/payment_settings_page.dart';

class SettingPage extends StatefulWidget {
  final PaymentSettingsPageController paymentSettingsPageController;
  const SettingPage({
    required this.paymentSettingsPageController,
    super.key,
  });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsets.all(12),
            tabs: const [
              Text('Métodos de pagamento'),
              Text('Outros'),
            ],
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                PaymentMethodsSettingsPage(
                  controller: widget.paymentSettingsPageController,
                ),
                const Text('conteúdo 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
