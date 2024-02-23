import 'package:auto_care/core/constant/imports.dart';

class CustomDropDownButton extends StatelessWidget {
  final String? hintText;
  final List<String> items;
  final String hint;
  final bool? isEnabled;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  const CustomDropDownButton({
    this.validator,
    this.value,
    this.isEnabled = true,
    required this.hint,
    super.key,
    required this.onChanged,
    required this.items,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: DropdownButtonFormField(
              validator: validator,
              decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 3)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.greyColor, width: 1.5)),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                        color: AppColors.primaryColor, width: 1.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: AppColors.secondaryColor,
                    ),
                  )),
              hint: Text(
                hint,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: value,
              onChanged: isEnabled == false ? null : onChanged),
        ));
  }
}
