import 'package:flutter/widgets.dart';
import 'package:leechineo_panel/features/user/domain/entities/user_entity.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserEditorPageForm {
  late final TextEditingController nameController;
  late final TextEditingController surnameController;
  late final TextEditingController cpfController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final MaskTextInputFormatter cpfFormatter;
  late final GlobalKey<FormState> formKey;

  final UserEntity user;

  UserEditorPageForm(this.user) {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    surnameController = TextEditingController();
    cpfController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {
        "#": RegExp(r'[0-9]'),
      },
      type: MaskAutoCompletionType.lazy,
    );

    nameController.text = user.name;
    surnameController.text = user.surname;
    cpfController.text = user.cpf;
    emailController.text = user.email;
  }
}
