import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:flutter/material.dart';

class CarOwnerRegister extends StatelessWidget {
  const CarOwnerRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Center(
      heightFactor: 2,
      child: Text(
        'After Registration , You should Add Your Cars',
        style: theme.bodyLarge!.copyWith(color: AppColors.secondaryColor),
      ),
    );
  }
}