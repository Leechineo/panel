import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/zipcode_searcher/controllers/zipcode_searcher/zipcode_searcher_controller.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_ilustration.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';

class ZipcodeSearcher extends StatelessWidget {
  final void Function(AddressEntityImpl address) onFound;
  final ZipcodeSearcherController controller;
  final double? width;
  final double? height;
  const ZipcodeSearcher({
    required this.onFound,
    required this.controller,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.form.formKey,
      child: controller.builder(
        builder: (context, data) {
          return AppCard(
            width: width ?? 470,
            height: height ?? 200,
            titleText: data.loading ? 'Buscando CEP...' : 'Buscar CEP',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            actions: [
              FilledButton(
                onPressed: data.loading
                    ? null
                    : () => controller.methods.submitForm(onFound),
                child: const Text('Buscar'),
              )
            ],
            child: Center(
              child: data.loading
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const AppIlustration(
                          AppIlustrations.locationSearch,
                          width: 120,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: controller.form.zipcodeController,
                          inputFormatters: [
                            controller.form.zipcodeFormatter,
                          ],
                          validator: (value) {
                            if (value != null) {
                              if (value.length < 9) {
                                return 'CEP inválido';
                              }
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) =>
                              controller.methods.submitForm(onFound),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            labelText: 'CEP*',
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
        allowAlertDialog: true,
      ),
    );
  }
}
