import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/data/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TowCarOwnerHomePageDrawer extends StatelessWidget {
  const TowCarOwnerHomePageDrawer({
    super.key,
    required this.drawerKey,
  });

  final GlobalKey<DrawerControllerState> drawerKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: drawerKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: towCarOwnerDrawerListTile.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(towCarOwnerDrawerListTile[index].title),
                        leading: Icon(
                          towCarOwnerDrawerListTile[index].leadingIcon,
                          size: 30,
                        ),
                        titleTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        textColor: AppColors.primaryColor,
                        iconColor: AppColors.primaryColor,
                        onTap: () {
                          Get.toNamed(towCarOwnerDrawerListTile[index].route);
                        },
                      )),
              TextButton.icon(
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
                  label: const Text('Logout', style: TextStyle(fontSize: 18)))
            ],
          ),
        ),
      ),
    );
  }
}
