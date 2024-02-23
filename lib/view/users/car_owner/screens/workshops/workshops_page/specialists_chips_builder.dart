import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/workshops_cubit.dart/workshops_cubit.dart';
import 'package:chips_choice/chips_choice.dart';

class SpecialistsChipsBuilder extends StatelessWidget {
  const SpecialistsChipsBuilder({
    super.key,
    required this.cubit,
  });

  final WorkshopsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      padding: const EdgeInsets.all(4),
      wrapped: false,
      alignment: WrapAlignment.start,
      value: cubit.selectedSpecialistIndex,
      onChanged: (value) {
        cubit.updateSelectedSpecialist(value);
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: cubit.chipSpecialists,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greyColor,
        selectedStyle: C2ChipStyle.filled(color: AppColors.primaryColor),
      ),
    );
  }
}
