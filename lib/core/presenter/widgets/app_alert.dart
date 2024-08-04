import 'package:flutter/material.dart';

enum AlertType { success, error, warning, info }

class AppAlert extends StatelessWidget {
  final AlertType type;
  final String title;
  final String message;

  const AppAlert({
    super.key,
    required this.type,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    IconData iconData;

    switch (type) {
      case AlertType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case AlertType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
      case AlertType.warning:
        backgroundColor = Colors.orange;
        iconData = Icons.warning;
        break;
      case AlertType.info:
        backgroundColor = Colors.blue;
        iconData = Icons.info;
        break;
    }

    return Card(
      color: backgroundColor.withOpacity(0.1),
      child: ListTile(
        leading: Icon(iconData, color: backgroundColor),
        title: Text(
          title,
          style: TextStyle(
            color: backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(message),
      ),
    );
  }
}
