import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/view/users/tow_car_owner/cubits/cubit/tow_car_owner_home_page_cubit.dart';
import 'package:flutter/material.dart';

class ChangeStatusButton extends StatelessWidget {
  const ChangeStatusButton({
    super.key,
    required this.cubit,
  });

  final TowCarOwnerHomePageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: cubit.isAvailable,
      onChanged: (isAvailable) {
        cubit.changeStatus();
      },
      activeColor: AppColors.secondaryColor,
    );
  }
}