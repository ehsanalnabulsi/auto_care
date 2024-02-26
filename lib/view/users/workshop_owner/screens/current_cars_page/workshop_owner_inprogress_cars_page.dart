import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/workshop_owner/cubits/workshop_owner_inprogress_cars_cubit/workshop_owner_inprogress_cars_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class WorkshopOwnerInProgressCarsPage extends StatelessWidget {
  const WorkshopOwnerInProgressCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) => WorkshopOwnerInProgressCarCubit()..getCurrentCars(),
      child: BlocConsumer<WorkshopOwnerInProgressCarCubit,
          WorkshopOwnerInProgressCarState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WorkshopOwnerInProgressCarCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Home Page')),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InProgressCars(theme: theme),
                    SizedBox(child: CarCardBuilder(cubit: cubit, theme: theme)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InProgressCars extends StatelessWidget {
  const InProgressCars({
    super.key,
    required this.theme,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Current Cars',
              style: theme.titleLarge!.copyWith(color: AppColors.primaryColor),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor.withOpacity(0.85)),
              )),
        ],
      ),
    );
  }
}

class CarCardBuilder extends StatelessWidget {
  const CarCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final WorkshopOwnerInProgressCarCubit cubit;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: cubit.currentCars.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Get.toNamed(CarOwnerRoutes.carDetailsPage,
                  arguments: {'carDetails': cubit.currentCars[index]});
            },
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 125,
                    height: 125,
                    margin: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: cubit.currentCars[index]['avatar'] == null
                            ? Image.asset(
                                ImageAsset.carImage,
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                cubit.currentCars[index]['avatar'],
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                Expanded(
                  flex: 3,
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
                              '${cubit.currentCars[index]['brandName']} ${cubit.currentCars[index]['modelName']}',
                              style: theme.titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            Text(
                              '${cubit.currentCars[index]['originName']} - ${cubit.currentCars[index]['plateNumber']}',
                              style: theme.titleSmall,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
