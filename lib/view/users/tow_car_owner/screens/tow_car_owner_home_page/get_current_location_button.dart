import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/view/users/tow_car_owner/cubits/cubit/tow_car_owner_home_page_cubit.dart';
import 'package:flutter/material.dart';

class GetCurrentLocationButton extends StatelessWidget {
  const GetCurrentLocationButton({
    super.key,
    required this.cubit,
  });

  final TowCarOwnerHomePageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: TextButton(
          onPressed: () {
            cubit.getCurrentLocation();
          },
          child: const Text('Error Loading Map,Press retry'),
        ),
      ),
    );
  }
}
