import 'package:auto_care/core/constant/imports.dart';

class StoreNameField extends StatelessWidget {
  const StoreNameField({
    super.key,
    required this.storeNameController,
  });

  final TextEditingController storeNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          return validateInput(value, 4, 40, 'storeName');
        },
        isPassword: false,
        labelText: 'Store Name',
        hintText: 'Omar-Bek Workshop',
        textInputType: TextInputType.name,
        prefixIcon: Icons.store,
        controller: storeNameController);
  }
}
