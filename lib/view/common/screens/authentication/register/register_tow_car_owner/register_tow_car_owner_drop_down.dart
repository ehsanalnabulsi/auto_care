import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/register/tow_car_owner/register_tow_car_owner_cubit.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';

class SelectOriginAndCoverageCity extends StatelessWidget {
  const SelectOriginAndCoverageCity({
    super.key,
    required this.cubit,
  });

  final RegisterTowCarOwnerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDropDownButton(
            validator: (value) {
              return validateInput(value, 1, 14, 'coverageCity');
            },
            hint: 'Coverage City',
            onChanged: (value) {
              cubit.updateSelectedCity(value);
            },
            items: cubit.citiesNames,
          ),
        ),
        Expanded(
          child: CustomDropDownButton(
            validator: (value) {
              return validateInput(value, 1, 14, 'origin');
            },
            hint: 'Select Car Origin',
            onChanged: (value) {
              cubit.getBrandsBySelectedOrigin(value);
            },
            items: cubit.originsNames,
          ),
        ),
      ],
    );
  }
}
