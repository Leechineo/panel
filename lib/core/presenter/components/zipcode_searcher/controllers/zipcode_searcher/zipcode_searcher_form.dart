import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ZipcodeSearcherForm {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController zipcodeController;
  late final MaskTextInputFormatter zipcodeFormatter;

  ZipcodeSearcherForm() {
    zipcodeController = TextEditingController();

    zipcodeFormatter = MaskTextInputFormatter(
      mask: '#####-###',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy,
    );
  }
}
