import 'package:auto_care/core/constant/imports.dart';

class ContactNumberField extends StatelessWidget {
  const ContactNumberField({
    super.key,
    required this.contactNumberController,
  });

  final TextEditingController contactNumberController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          return validateInput(value, 10, 10, 'contactNumber');
        },
        prefixIcon: Icons.contact_phone_outlined,
        labelText: 'Contact Number',
        textInputType: TextInputType.number,
        controller: contactNumberController);
  }
}
