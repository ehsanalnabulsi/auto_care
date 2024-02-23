import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/data/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileBuilder extends StatelessWidget {
  const ListTileBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding:const EdgeInsets.all(20),
              leading: Icon(selectTypeTile[index].leadingIcon, size: 40),
              tileColor: selectTypeTile[index].color,
              title: Text(selectTypeTile[index].title),
              subtitle: Text(selectTypeTile[index].subTitle),
              subtitleTextStyle: const TextStyle(fontSize: 18),
              textColor: AppColors.whiteColor,
              titleTextStyle: const TextStyle(fontSize: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              trailing: const Icon(Icons.arrow_right, size: 36),
              iconColor: AppColors.whiteColor,
              onTap: () {
                Get.toNamed(selectTypeTile[index].route);
              },
            )),
        separatorBuilder: (context, index) => Container(),
        itemCount: 4);
  }
}
