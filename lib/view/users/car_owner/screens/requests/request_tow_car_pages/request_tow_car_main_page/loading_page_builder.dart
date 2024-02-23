import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:flutter/material.dart';

class LoadingPageBuilder extends StatelessWidget {
  const LoadingPageBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: AppColors.whiteColor,
      child: const AppProgressIndicator(),
    );
  }
}
