import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/register/parts_supplier/register_parts_supplier_cubit.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';

class SelectOriginAndSpecialist extends StatelessWidget {
  const SelectOriginAndSpecialist({
    super.key,
    required this.cubit,
  });

  final RegisterPartsSupplierCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownButton(
      validator: (value) {
        return validateInput(value, 1, 14, 'origin');
      },
      hint: 'Select Car Origin',
      onChanged: (value) {
        cubit.getBrandsBySelectedOrigin(value);
      },
      items: cubit.originsNames,
    );
  }
}
