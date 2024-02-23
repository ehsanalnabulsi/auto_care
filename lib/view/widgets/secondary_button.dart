import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final double borderRadius = 10;
  const SecondaryButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            // backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 12), // set the button's padding
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.primaryColor),
              // set the button's border radius
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: child, // set the button's label
        ),
      ),
    );
  }
}
