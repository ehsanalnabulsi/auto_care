import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';
import 'package:auto_care/view/common/cubits/register/workshop_owner/register_workshop_owner_cubit.dart';

class SelectOriginAndSpecialist extends StatelessWidget {
  const SelectOriginAndSpecialist({
    super.key,
    required this.cubit,
  });

  final RegisterWorkshopOwnerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: CustomDropDownButton(
              validator: (value) {
                return validateInput(value, 1, 14, 'specialist');
              },
              hint: 'Select Specialist',
              onChanged: (value) {
                cubit.updateSelectedSpecialist(value);
              },
              items: cubit.specialistsNames),
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
