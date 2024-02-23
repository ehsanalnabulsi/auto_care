import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';

class ShareAppTile extends StatelessWidget {
  const ShareAppTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.whiteColor,
      ),
      child: ListTile(
        iconColor: AppColors.primaryColor,
        title: Text('Share App',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
        onTap: () {},
        trailing: const Icon(Icons.arrow_right, size: 28.0),
        leading: const Icon(Icons.share, size: 28.0),
        textColor: AppColors.primaryColor,
      ),
    );
  }
}
