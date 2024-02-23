import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/open_drawer_button.dart';
import 'package:flutter/material.dart';

class OpenDrawerAndChangeStatusButtons extends StatelessWidget {
  const OpenDrawerAndChangeStatusButtons({
    super.key,
    required this.scaffoldKey,
    required this.cubit,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final RequestTowCarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OpenDrawerButton(scaffoldKey: scaffoldKey),
         
        ],
      ),
    );
  }
}
