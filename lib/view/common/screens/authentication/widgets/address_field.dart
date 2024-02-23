import 'package:auto_care/core/constant/imports.dart';

class AddressField extends StatelessWidget {
  const AddressField({
    super.key,
    required this.addressController,
  });

  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          return validateInput(value, 1, 40, 'address');
        },
        textInputType: TextInputType.streetAddress,
        prefixIcon: Icons.location_pin,
        hintText: 'Syria, Damascus, AL-Sha3lan',
        labelText: 'Address',
        controller: addressController);
  }
}
