import 'dart:io';

import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/register/workshop_owner/register_workshop_owner_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/workshop_name_field.dart';

class WorkshopAvatarAndNameRow extends StatelessWidget {
  const WorkshopAvatarAndNameRow({
    super.key,
    required this.cubit,
    required this.storeNameController,
  });

  final RegisterWorkshopOwnerCubit cubit;
  final TextEditingController storeNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: PickLogoWidget(
          cubit: cubit,
        )),
        Expanded(
          flex: 3,
          child: WorkshopNameField(workshopNameController: storeNameController),
        ),
      ],
    );
  }
}

class PickLogoWidget extends StatelessWidget {
  const PickLogoWidget({
    super.key,
    required this.cubit,
  });

  final RegisterWorkshopOwnerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            radius: 40,
            backgroundImage: cubit.pickedLogo != null
                ? Image.file(File(cubit.pickedLogo!.path)).image
                : Image.asset(ImageAsset.defaultAvatar).image,
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
