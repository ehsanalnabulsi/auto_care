import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/login/login_cubit.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.formKey,
    required this.cubit,
    required this.phoneController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final LoginCubit cubit;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          cubit.userLogin(
              phoneNumber: phoneController.text,
              password: passwordController.text);
        }
      },
      textButton: 'Login',
    );
  }
}
