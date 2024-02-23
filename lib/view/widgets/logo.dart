import 'package:flutter/material.dart';

import '../../core/constant/image_asset.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 150,
        child: Image(
            image: AssetImage(
          ImageAsset.logo,
        )));
  }
}
