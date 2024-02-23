import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RegisterHeader extends StatelessWidget {
  final String title;
  const RegisterHeader({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Register',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: AppColors.primaryColor),
              textAlign: TextAlign.left,
            )
                .animate(delay: 100.ms)
                .fadeIn()
                .scale()
                .move(delay: 100.ms, duration: 600.ms)
                .shimmer(delay: 150.ms)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
