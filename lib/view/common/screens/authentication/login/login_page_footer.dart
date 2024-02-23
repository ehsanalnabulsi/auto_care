
import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageFooter extends StatelessWidget {
  const LoginPageFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t Have an Account ?'),
        TextButton(
          onPressed: () => Get.toNamed(SharedRoutes.registerMainPage),
          child: const Text(
            'Sign Up',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
