import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/components/zipcode_searcher/zipcode_searcher.dart';
import 'package:leechineo_panel/core/presenter/components/address_selector/controllers/address_creator/address_creator_controller.dart';

class AddressCreator extends StatelessWidget {
  final AddressCreatorController controller;
  const AddressCreator({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: controller.builder(
          builder: (context, data) {
            if (data.zipcodeValidated) {
              return Column(
                children: [
                  TextFormField(
                    controller: controller.form.zipcodeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CEP',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.form.nameController,
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Nome do remetente',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.form.cpfController,
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'CPF do remetente',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: controller.form.cityController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.form.streetController,
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Rua/Logradouro*',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.form.numberController,
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Número*',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.form.districtController,
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Bairro',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.form.complementController,
                          decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Complemento/Referência',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    inputFormatters: [
                      controller.form.phoneNumberFormatter,
                    ],
                    decoration: const InputDecoration(
                      prefixText: '+55 ',
                      border: OutlineInputBorder(),
                      labelText: 'Celular*',
                      isDense: true,
                    ),
                  ),
                ],
              );
            }
            return ZipcodeSearcher(
              controller: controller.zipcodeSearcherController,
              onFound: (address) {
                controller.methods.updateData(address, data.user);
              },
            );
          },
        ),
      ),
    );
  }
}
