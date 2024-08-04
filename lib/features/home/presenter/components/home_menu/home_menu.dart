import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/home/data/models/home_menu_list_item_model.dart';
import 'package:leechineo_panel/features/home/presenter/components/home_menu/home_menu_item.dart';

class HomeMenu extends StatelessWidget {
  final void Function(String route) onRouteSelected;
  final String currentRoute;
  HomeMenu({
    required this.onRouteSelected,
    required this.currentRoute,
    super.key,
  });

  final List<HomeMenuListItemModel> menuItems = [
    HomeMenuListItemModel(
      icon: Icons.analytics_rounded,
      title: 'Início',
      route: '/home/main/',
    ),
    HomeMenuListItemModel(
      icon: Icons.folder_rounded,
      title: 'Arquivos',
      route: '/home/cloud_file/',
    ),
    HomeMenuListItemModel(
      icon: Icons.inventory_2_rounded,
      title: 'Estoques',
      route: '/home/stock/',
    ),
    HomeMenuListItemModel(
      icon: Icons.shopping_bag_rounded,
      title: 'Produtos',
      route: '/home/product/',
    ),
    HomeMenuListItemModel(
      icon: Icons.space_dashboard_rounded,
      title: 'Seções',
      route: '/home/home_section/',
    ),
    HomeMenuListItemModel(
      icon: Icons.segment_rounded,
      title: 'Categorias',
      route: '/home/category/',
    ),
    HomeMenuListItemModel(
      icon: Icons.style_rounded,
      title: 'Marcas',
      route: '/home/brand/',
    ),
    HomeMenuListItemModel(
      icon: Icons.loyalty_rounded,
      title: 'Cupons e promoções',
      route: '/home/promotion/',
    ),
    HomeMenuListItemModel(
      icon: Icons.local_shipping_rounded,
      title: 'Métodos de envio',
      route: '/home/shipping_method/',
    ),
    HomeMenuListItemModel(
      icon: Icons.manage_accounts_rounded,
      title: 'Clientes',
      route: '/home/user/',
    ),
    HomeMenuListItemModel(
      icon: Icons.shopping_basket_rounded,
      title: 'Pedidos',
      route: '/home/order/',
    ),
    // HomeMenuListItemModel(
    //   icon: Icons.credit_card_rounded,
    //   title: 'Financeiro',
    //   route: '/home/financial_module/',
    // ),
    // HomeMenuListItemModel(
    //   icon: Icons.admin_panel_settings_rounded,
    //   title: 'Gerenciar ADMs',
    //   route: '/home/admin/',
    // ),
    HomeMenuListItemModel(
      icon: Icons.settings_rounded,
      title: 'Configurações',
      route: '/home/setting/',
    ),
    HomeMenuListItemModel(
      icon: Icons.fact_check_rounded,
      title: 'Registros',
      route: '/home/log/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: menuItems.map<Widget>(
        (item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: HomeMenuItem(
              onItemSelected: (item) {
                onRouteSelected(item.route);
              },
              homeMenuListItem: item,
              active: currentRoute.contains(item.route),
            ),
          );
        },
      ).toList(),
    );
  }
}
