import 'package:flutter/material.dart';

class SelectUserTypeListTile {
  late final String title;
  late final String subTitle;
  late final IconData leadingIcon;
  late final dynamic route;

  late final Color color;
  SelectUserTypeListTile(
      {required this.title,
      required this.subTitle,
      required this.leadingIcon,
      required this.route,
      required this.color});
}

class TowCarOwnerDrawerListTile {
  late final String title;

  late final IconData leadingIcon;
  late final dynamic route;

  TowCarOwnerDrawerListTile({
    required this.title,
    required this.leadingIcon,
    required this.route,
  });
}
