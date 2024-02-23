import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/functions/form_fields_validator.dart';
import 'package:auto_care/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.cubit,
    required this.passwordController,
  });

  final dynamic cubit;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      suffixPressed: () {
        cubit.changePasswordVisibility();
      },
      isPassword: cubit.isPassword,
      validator: (value) {
        return validateInput(value, 8, 64, 'password');
      },
      textInputType: TextInputType.visiblePassword,
      labelText: 'Password',
      controller: passwordController,
      prefixIcon: Icons.password_rounded,
      suffixIcon: cubit.suffix,
      hintText: '12XxyY@!',
    );
  }
}
