import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';

showAlertDialog(
  BuildContext context, {
  String? titleText,
  String? message,
  Icon? icon,
  void Function()? onClosed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: AppCard(
          width: 500,
          height: 200,
          titleText: titleText,
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                onClosed?.call();
              },
              child: const Text('Fechar'),
            ),
          ],
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ??
                    const Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 70,
                    ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  message ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
