import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
        ),
        onPressed: () {
          CacheHelper.remove(key: 'token');
          CacheHelper.remove(key: 'userType')
              .then((value) => Get.offAllNamed(SharedRoutes.login));
        },
        icon: const Icon(
          Icons.logout,
          size: 24,
        ),
        label: const Text('Logout', style: TextStyle(fontSize: 18)));
  }
}
