import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already Have an Account ?'),
        TextButton(
          onPressed: () => Get.toNamed(SharedRoutes.login),
          child: const Text(
            'Sign In',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
