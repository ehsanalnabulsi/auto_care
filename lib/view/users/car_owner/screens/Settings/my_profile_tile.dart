import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfileTile extends StatelessWidget {
  const MyProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.whiteColor,
      ),
      child: ListTile(
        iconColor: AppColors.primaryColor,
        title: Text('My Profile',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        onTap: () => Get.toNamed(CarOwnerRoutes.editProfile),
        trailing: const Icon(Icons.arrow_right, size: 28.0),
        leading: const Icon(Icons.person_outlined, size: 28.0),
        textColor: AppColors.primaryColor,
      ),
    );
  }
}
