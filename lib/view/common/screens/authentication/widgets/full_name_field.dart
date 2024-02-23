import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/functions/form_fields_validator.dart';
import 'package:auto_care/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FullNameField extends StatelessWidget {
  const FullNameField({
    super.key,
    required this.fullNameController,
  });

  final TextEditingController fullNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        return validateInput(value, 3, 32, 'fullName');
      },
      prefixIcon: Icons.person_2_outlined,
      textInputType: TextInputType.name,
      labelText: 'Full Name',
      controller: fullNameController,
      isPassword: false,
      hintText: 'Mohammed Ahmad',
    );
  }
}
