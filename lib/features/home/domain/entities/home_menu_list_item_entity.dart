import 'package:flutter/cupertino.dart';

abstract class HomeMenuListItemEntity {
  final IconData icon;
  final String title;
  final String route;

  HomeMenuListItemEntity({
    required this.icon,
    required this.title,
    required this.route,
  });
}
