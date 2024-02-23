import 'package:auto_care/core/functions/form_fields_validator.dart';
import 'package:auto_care/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
  });

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: (value) {
        return validateInput(value, 3, 32, 'phoneNumber');
      },
      prefixIcon: Icons.phone_enabled_outlined,
      textInputType: TextInputType.phone,
      labelText: 'Phone Number',
      controller: phoneController,
      isPassword: false,
      hintText: '09xxxxxxxx',
    );
  }
}
