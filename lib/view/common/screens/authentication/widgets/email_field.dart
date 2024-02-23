import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/functions/form_fields_validator.dart';
import 'package:auto_care/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          return validateInput(value, 3, 32, 'email');
        },
        prefixIcon: Icons.email_outlined,
        labelText: 'Email Address',
        hintText: 'westingtime@autocare.com',
        textInputType: TextInputType.emailAddress,
        controller: emailController);
  }
}
