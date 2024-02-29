import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/home_page_cubit/car_owner_home_page_cubit.dart';
import 'package:get/get.dart';

class PartsSuppliersCardBuilder extends StatelessWidget {
  const PartsSuppliersCardBuilder({super.key, required this.cubit});
  final CarOwnerHomePageCubit cubit;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 150,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: 250,
                  height: 150,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(CarOwnerRoutes.partsSuppliers);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: cubit.partsSuppliers[index]['storeAvatar'] ==
                                  null
                              ? Image.asset(
                                  ImageAsset.defaultImage,
                                  fit: BoxFit.cover,
                                  width: 250,
                                  height: 150,
                                )
                              : Image.network(
                                  cubit.partsSuppliers[index]['storeAvatar'],
                                  fit: BoxFit.cover,
                                  width: 250,
                                  height: 150,
                                ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.partsSuppliers[index]['storeName'],
                                    style: theme.titleLarge!.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    cubit.partsSuppliers[index]['originName'],
                                    style: theme.titleMedium!.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => AppColors.whiteColor
                                                .withOpacity(0.2)),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'See More...',
                                    style: theme.titleMedium!.copyWith(
                                        color: AppColors.secondaryColor),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: cubit.partsSuppliers.length),
    );
  }
}
