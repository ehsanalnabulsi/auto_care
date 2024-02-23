import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';

class AppSettingsTile extends StatelessWidget {
  const AppSettingsTile({
    super.key,
    required this.theme,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.whiteColor,
      ),
      margin: const EdgeInsets.all(2.0),
      child: ExpansionTile(
        backgroundColor: AppColors.whiteColor,
        collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), side: BorderSide.none),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        initiallyExpanded: true,
        iconColor: AppColors.primaryColor,
        leading: const Icon(Icons.settings, size: 28.0),
        title: Text('App Settings',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('App Theme', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('Language', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
        ],
      ),
    );
  }
}
