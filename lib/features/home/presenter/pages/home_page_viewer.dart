import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:leechineo_panel/features/home/presenter/components/home_menu/home_menu.dart';
import 'package:leechineo_panel/features/home/presenter/widgets/home_menu_avatar.dart';

class HomePageViewer extends StatelessWidget {
  final bool showDrawerMenu;
  final String currentRoute;
  final void Function(String route) onRouteSelected;
  final void Function() onPop;
  final bool showBackButton;
  final Widget pageViewer;
  final UserEntity user;
  final void Function() onLogout;
  final bool loggingOut;

  const HomePageViewer({
    required this.currentRoute,
    required this.onRouteSelected,
    required this.pageViewer,
    required this.onPop,
    required this.showBackButton,
    required this.loggingOut,
    required this.onLogout,
    required this.user,
    this.showDrawerMenu = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawerMenu
          ? Drawer(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: HomeMenu(
                    currentRoute: currentRoute,
                    onRouteSelected: (route) => onRouteSelected(route),
                  ),
                ),
              ),
            )
          : null,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, right: 12),
          child: AppCard(
            height: 60,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed: onPop,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),
                Text(
                  'Leechineo',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                HomeMenuAvatar(
                  user: user,
                  onLogout: onLogout,
                  loggingOut: loggingOut,
                ),
              ],
            ),
          ),
        ),
      ),
      body: pageViewer,
    );
  }
}
