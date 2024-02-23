
import 'package:auto_care/view/users/tow_car_owner/cubits/cubit/tow_car_owner_home_page_cubit.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/change_status_button.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/open_drawer_button.dart';
import 'package:flutter/material.dart';

class OpenDrawerAndChangeStatusButtons extends StatelessWidget {
  const OpenDrawerAndChangeStatusButtons({
    super.key,
    required this.scaffoldKey,
    required this.cubit,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final TowCarOwnerHomePageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OpenDrawerButton(scaffoldKey: scaffoldKey),
          ChangeStatusButton(cubit: cubit),
        ],
      ),
    );
  }
}
