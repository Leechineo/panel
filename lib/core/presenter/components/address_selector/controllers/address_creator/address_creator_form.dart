import 'package:flutter/material.dart';
import 'package:leechineo_panel/features/address/data/entities/address_entity_impl.dart';
import 'package:leechineo_panel/features/address/domain/entities/address_entity.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddressCreatorForm {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController complementController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final MaskTextInputFormatter zipcodeFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.lazy,
  );
  final MaskTextInputFormatter cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.lazy,
  );
  final MaskTextInputFormatter phoneNumberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
    type: MaskAutoCompletionType.lazy,
  );

  final AddressEntity? address;
  final UserEntity? user;

  AddressCreatorForm({
    this.address,
    this.user,
  });

  void updateForm({
    required AddressEntityImpl address,
    required UserEntity user,
  }) {
    zipcodeController.text = address.zipcode;
    nameController.text =
        user.id.isNotEmpty ? '${user.name} ${user.surname}' : '';
    cpfController.text = user.cpf;
    cityController.text =
        address.zipcode.isNotEmpty ? '${address.city}-${address.state}' : '';
  }
}
