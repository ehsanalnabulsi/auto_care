import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/workshops_cubit.dart/workshops_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkshopsGridViewBuilder extends StatelessWidget {
  const WorkshopsGridViewBuilder({
    super.key,
    required this.cubit,
  });

  final WorkshopsCubit cubit;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return GridView.builder(
      itemCount: cubit.workshops.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Get.toNamed(CarOwnerRoutes.workshopDetails, arguments: {
              'workshopDetails': cubit.workshops[index],
              'cubit': cubit
            });
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: cubit.workshops[index]['avatar'] == null
                    ? Image.asset(
                        ImageAsset.defaultImage,
                        fit: BoxFit.cover,
                        width: 250,
                      )
                    : Image.network(
                        cubit.workshops[index]['avatar'],
                        fit: BoxFit.cover,
                        width: 250,
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.workshops[index]['workshopName'],
                            style: theme.titleLarge!.copyWith(
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                          Text(
                            cubit.workshops[index]['specialistName'],
                            style: theme.titleMedium!.copyWith(
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'See More...',
                        style: theme.titleMedium!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // number of items in each row
        mainAxisSpacing: 2.0, // spacing between rows
        crossAxisSpacing: 2.0, // spacing between columns
      ),
    );
  }
}
