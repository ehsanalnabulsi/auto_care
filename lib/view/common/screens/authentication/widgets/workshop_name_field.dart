import 'package:auto_care/core/constant/imports.dart';

class WorkshopNameField extends StatelessWidget {
  const WorkshopNameField({
    super.key,
    required this.workshopNameController,
  });

  final TextEditingController workshopNameController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        validator: (value) {
          return validateInput(value, 4, 40, 'workshopName');
        },
        isPassword: false,
        labelText: 'Workshop Name',
        hintText: 'A-Baker Workshop',
        textInputType: TextInputType.name,
        prefixIcon: Icons.work_outline_outlined,
        controller: workshopNameController);
  }
}
