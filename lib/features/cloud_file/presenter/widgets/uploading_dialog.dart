import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';

class UploadingDialog extends StatelessWidget {
  final bool uploading;
  const UploadingDialog({
    required this.uploading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        height: 150,
        width: 500,
        titleText: uploading ? 'Enviando arquivos...' : 'Arquivos enviados!',
        actions: [
          FilledButton(
            onPressed: uploading
                ? null
                : () {
                    Navigator.pop(context);
                  },
            child: const Text('Concluir'),
          ),
        ],
        child: Center(
          child: uploading
              ? const CircularProgressIndicator()
              : const AppIlustration(
                  AppIlustrations.wellDone,
                  height: 120,
                ),
        ),
      ),
    );
  }
}
