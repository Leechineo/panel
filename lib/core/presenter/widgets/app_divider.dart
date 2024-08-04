import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final bool vertical;
  final double? height;
  const AppDivider({this.vertical = false, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: vertical ? height : 1,
      width: vertical ? 1 : null,
      color: Theme.of(context).focusColor,
    );
  }
}