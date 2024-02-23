import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/workshops_cubit.dart/workshops_cubit.dart';
import 'package:chips_choice/chips_choice.dart';

class OriginsChipsBuilder extends StatelessWidget {
  const OriginsChipsBuilder({
    super.key,
    required this.cubit,
  });

  final WorkshopsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      wrapped: false,
      runSpacing: 2,
      alignment: WrapAlignment.start,
      value: cubit.selectedOriginIndex,
      onChanged: (value) {
        cubit.updateSelectedOrigin(value);
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: cubit.chipOrigins,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greyColor,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 4),
        selectedStyle: C2ChipStyle.filled(color: AppColors.primaryColor),
      ),
      spacing: 3,
    );
  }
}

