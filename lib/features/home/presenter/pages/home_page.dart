import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/home/presenter/components/home_menu/home_menu.dart';
import 'package:leechineo_panel/features/home/presenter/controllers/home_page_controller.dart';
import 'package:leechineo_panel/features/home/presenter/pages/home_page_viewer.dart';

class HomePage extends StatelessWidget {
  final HomePageController controller;
  const HomePage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final DisplayHelper displayHelper = DisplayHelper(context);
        return controller.builder(
          builder: (context, data) {
            return Scaffold(
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (displayHelper.moreThanSm)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                      child: AppCard(
                        width: 260,
                        height: constraints.maxHeight - 32,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: HomeMenu(
                              currentRoute: data.route,
                              onRouteSelected: (route) {
                                controller.methods.goToRoute(route);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: HomePageViewer(
                      showDrawerMenu: displayHelper.lessThanMd,
                      currentRoute: data.route,
                      onRouteSelected: (route) {
                        controller.methods.goToRoute(route);
                      },
                      pageViewer: controller.methods.pageViewer(context),
                      onPop: controller.methods.onPop,
                      showBackButton: true,
                      loggingOut: data.loggingOut,
                      onLogout: controller.methods.logout,
                      user: data.user,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
