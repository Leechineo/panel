import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leechineo_panel/features/splash/presenter/controllers/splash_controller.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashPage extends StatefulWidget {
  final SplashController splashController;
  const SplashPage({required this.splashController, super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: 100,
              child: LoadingIndicator(
                indicatorType: Indicator.ballScale,
                colors: [Theme.of(context).buttonTheme.colorScheme!.primary],
              ),
            ),
            SizedBox(
              width: 100,
              child: SvgPicture.asset(
                'assets/Ilustrations/app/logo.svg',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
