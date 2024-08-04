import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_divider.dart';
import 'package:leechineo_panel/features/user/presenter/controller/user_editor_page_controller/user_editor_page_controller.dart';
import 'package:leechineo_panel/features/user/presenter/validators/cpf_validator.dart';
import 'package:leechineo_panel/features/user/presenter/validators/email_validator.dart';

class UserEditorPage extends StatefulWidget {
  final UserEditorController userEditorController;
  const UserEditorPage({required this.userEditorController, super.key});

  @override
  State<UserEditorPage> createState() => _UserEditorPageState();
}

class _UserEditorPageState extends State<UserEditorPage> {
  @override
  void dispose() {
    widget.userEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 12, 12),
      child: Scaffold(
        body: widget.userEditorController.builder(
          builder: (context, data) {
            if (data.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Form(
              key: widget.userEditorController.form.formKey,
              child: Builder(
                builder: (context) {
                  final DisplayHelper displayHelper = DisplayHelper(context);
                  return AppCard(
                    flexible: true,
                    actions: [
                      FilledButton(
                        onPressed: data.saving
                            ? null
                            : () {
                                if (widget.userEditorController.form.formKey
                                    .currentState!
                                    .validate()) {
                                  if (data.user.id.isEmpty) {
                                    widget.userEditorController.methods
                                        .createUser(
                                      data.editUser,
                                      widget.userEditorController.form
                                          .passwordController.text,
                                    );
                                  } else {
                                    widget.userEditorController.methods
                                        .updateUser(
                                      data.editUser,
                                      widget.userEditorController.form
                                          .passwordController.text,
                                    );
                                  }
                                }
                              },
                        child: const Text('Salvar'),
                      )
                    ],
                    child: data.saving
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  AppCard(
                                    child: SizedBox(
                                      height:
                                          displayHelper.lessThanMd ? 110 : 50,
                                      child: Flex(
                                        direction: displayHelper.lessThanMd
                                            ? Axis.vertical
                                            : Axis.horizontal,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: CheckboxListTile(
                                              value: data.editUser.admin,
                                              title:
                                                  const Text('Administrador'),
                                              onChanged: (value) => widget
                                                  .userEditorController.methods
                                                  .toggleAdmin(),
                                            ),
                                          ),
                                          if (displayHelper.moreThanSm)
                                            const AppDivider(
                                              vertical: true,
                                              height: 30,
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: CheckboxListTile(
                                              value:
                                                  data.editUser.verifiedEmail,
                                              title: const Text(
                                                  'Email verificado'),
                                              onChanged: (value) => widget
                                                  .userEditorController.methods
                                                  .toggleVerifiedEmail(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  AppCard(
                                    titleText: 'Dados pessoais',
                                    contentPadding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: displayHelper.lessThanMd
                                              ? 110
                                              : 70,
                                          child: Flex(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            direction: displayHelper.lessThanMd
                                                ? Axis.vertical
                                                : Axis.horizontal,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  controller: widget
                                                      .userEditorController
                                                      .form
                                                      .nameController,
                                                  onChanged: (value) => widget
                                                      .userEditorController
                                                      .methods
                                                      .updateUserName(value),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Nome inválido';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    isDense: true,
                                                    labelText: 'Nome',
                                                  ),
                                                ),
                                              ),
                                              if (displayHelper.moreThanSm)
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                              Expanded(
                                                flex: 1,
                                                child: TextFormField(
                                                  controller: widget
                                                      .userEditorController
                                                      .form
                                                      .surnameController,
                                                  onChanged: (value) => widget
                                                      .userEditorController
                                                      .methods
                                                      .updateUserSurname(value),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Sobrenome inválido';
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    isDense: true,
                                                    labelText: 'Sobrenome',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  AppCard(
                                    titleText: 'Credenciais',
                                    contentPadding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          child: TextFormField(
                                            controller: widget
                                                .userEditorController
                                                .form
                                                .cpfController,
                                            onChanged: (value) => widget
                                                .userEditorController.methods
                                                .updateUserCpf(value),
                                            validator: (value) {
                                              if (!cpfValidator(value!)) {
                                                return 'CPF inválido';
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              widget.userEditorController.form
                                                  .cpfFormatter,
                                            ],
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              isDense: true,
                                              labelText: 'CPF',
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: widget
                                              .userEditorController
                                              .form
                                              .emailController,
                                          onChanged: (value) => widget
                                              .userEditorController.methods
                                              .updateEmail(value),
                                          validator: (value) {
                                            if (!emailValidator(value!)) {
                                              return 'Email inválido';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                            labelText: 'Email',
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: TextFormField(
                                            controller: widget
                                                .userEditorController
                                                .form
                                                .passwordController,
                                            validator: (value) {
                                              if (data.user.id.isEmpty) {
                                                if (value!.length < 8) {
                                                  return 'Senha inválida';
                                                }
                                              }
                                              if (value!.isNotEmpty) {
                                                if (value.length < 8) {
                                                  return 'Senha inválida';
                                                }
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              isDense: true,
                                              labelText: 'Nova senha',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  FilledButton.tonal(
                                    onPressed: () async {
                                      final date = await showDatePicker(
                                        locale: const Locale('pt', 'BR'),
                                        context: context,
                                        initialDate:
                                            data.editUser.birthday.toDate(),
                                        firstDate:
                                            DateTime(DateTime.now().year - 120),
                                        lastDate: DateTime.now(),
                                      );
                                      if (date != null) {
                                        widget.userEditorController.methods
                                            .updateBirthday(
                                          date,
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Aniversário: ${data.editUser.birthday.day.toString().padLeft(2, '0')}/${data.editUser.birthday.month.toString().padLeft(2, '0')}/${data.editUser.birthday.year}',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  );
                },
              ),
            );
          },
          eventListener: (context, event, data) {
            if (event.id == 'savedUser') {
              Navigator.maybePop(context);
            }
          },
          allowAlertDialog: true,
        ),
      ),
    );
  }
}
