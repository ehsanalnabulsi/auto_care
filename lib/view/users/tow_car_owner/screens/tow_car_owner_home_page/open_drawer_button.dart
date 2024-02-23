import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        scaffoldKey.currentState!.openDrawer();
      },
      icon: const Icon(Icons.menu),
      style: IconButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          elevation: 2,
          iconSize: 30.0,
          backgroundColor: AppColors.whiteColor),
    );
  }
}
