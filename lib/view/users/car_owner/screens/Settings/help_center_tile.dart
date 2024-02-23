import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';

class HelpCenterTile extends StatelessWidget {
  const HelpCenterTile({
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
      margin: const EdgeInsets.all(4.0),
      child: ExpansionTile(
        backgroundColor: AppColors.whiteColor,
        collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), side: BorderSide.none),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        initiallyExpanded: false,
        iconColor: AppColors.primaryColor,
        leading: const Icon(Icons.live_help_rounded, size: 28.0),
        title: Text('Help Center',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('Privacy Policy', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('Terms Of Service', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('FAQ', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('About Us', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('Contact Us', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
          ListTile(
              contentPadding: const EdgeInsets.only(left: 24.0, right: 24.0),
              iconColor: Colors.black54,
              onTap: () {},
              title: Text('Join Us', style: theme.bodyLarge),
              trailing: const Icon(Icons.arrow_right)),
        ],
      ),
    );
  }
}
