import 'dart:io';

import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';

class PickLogoWidget extends StatelessWidget {
  const PickLogoWidget({
    super.key,
    required this.cubit,
  });

  final dynamic cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 35,
            backgroundImage: cubit.pickedLogo != null
                ? Image.file(File(cubit.pickedLogo!.path)).image
                : Image.asset(ImageAsset.defaultLogo).image,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
            )),
        Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100)),
              child: GestureDetector(
                  onTap: () => cubit.pickLogo(),
                  child: const Icon(Icons.add_a_photo,
                      color: AppColors.whiteColor, size: 15.0)),
            ))
      ]),
    );
  }
}
