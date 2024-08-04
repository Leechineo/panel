import 'dart:math';

import 'package:flutter/material.dart';
import 'package:leechineo_panel/core/presenter/utils/display_helper.dart';
import 'package:leechineo_panel/core/presenter/widgets/app_card.dart';
import 'package:leechineo_panel/features/auth/presenter/controllers/login_page_controller.dart';

class LoginPage extends StatefulWidget {
  final LoginPageController controller;
  const LoginPage({required this.controller, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _passwordFocus = FocusNode();

  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leechineo'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final DisplayHelper displayHelper = DisplayHelper(context);
          return Center(
            child: Form(
              key: _formKey,
              child: AppCard(
                width: max<double>(10,
                    displayHelper.lessThanMd ? displayHelper.width - 12 : 300),
                contentPadding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: TextField(
                        focusNode: _emailFocus,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (value) => _passwordFocus.requestFocus(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                        focusNode: _passwordFocus,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSubmitted: (value) => widget.controller.methods.login(
                          _emailController.text,
                          _passwordController.text,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          isDense: true,
                        ),
                      ),
                    ),
                    widget.controller.builder(
                      builder: (context, data) {
                        if (data.loading) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: FilledButton(
                              onPressed: () => widget.controller.methods.login(
                                _emailController.text,
                                _passwordController.text,
                              ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                fixedSize: MaterialStateProperty.all(
                                  const Size(
                                    double.maxFinite,
                                    35,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Login',
                              ),
                            ),
                          );
                        }
                      },
                      allowAlertDialog: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
