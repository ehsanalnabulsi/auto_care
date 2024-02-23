import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';

import 'package:auto_care/view/users/car_owner/cubits/cars_page_cubit/cars_page_cubit.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';

class CarOwnerCarsPage extends StatelessWidget {
  const CarOwnerCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CarsPageCubit()..getUserCars(),
        ),
      ],
      child: BlocConsumer<CarsPageCubit, CarsPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CarsPageCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('My Cars'),
              ),
              body: ConditionalBuilder(
                  condition: state is GetUserCarsLoadingState,
                  builder: (context) => const Center(
                        child: AppProgressIndicator(),
                      ),
                  fallback: (context) => ConditionalBuilder(
                        condition: state is GetUserCarsSuccessState,
                        fallback: (context) =>
                            NoUserCarsFoundBody(theme: theme),
                        builder: (context) {
                          if (cubit.userCars.isEmpty) {
                            return NoUserCarsFoundBody(theme: theme);
                          }

                          return UserCarsBody(cubit: cubit, theme: theme);
                        },
                      )),
            ),
          );
        },
      ),
    );
  }
}

class UserCarsBody extends StatelessWidget {
  const UserCarsBody({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final CarsPageCubit cubit;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CarCardBuilder(cubit: cubit, theme: theme),
        const AddNewCarButton(),
      ],
    );
  }
}

class CarCardBuilder extends StatelessWidget {
  const CarCardBuilder({
    super.key,
    required this.cubit,
    required this.theme,
  });

  final CarsPageCubit cubit;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: cubit.userCars.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Get.toNamed(CarOwnerRoutes.carDetailsPage,
                  arguments: {'carDetails': cubit.userCars[index]});
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
                        child: cubit.userCars[index]['avatar'] == null
                            ? Image.asset(
                                ImageAsset.carImage,
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                cubit.userCars[index]['avatar'],
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
                              '${cubit.userCars[index]['brandName']} ${cubit.userCars[index]['modelName']}',
                              style: theme.titleLarge,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            Text(
                              '${cubit.userCars[index]['originName']} - ${cubit.userCars[index]['plateNumber']}',
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

class AddNewCarButton extends StatelessWidget {
  const AddNewCarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PrimaryButton(
        onPressed: () => Get.toNamed(CarOwnerRoutes.addNewCar),
        textButton: 'Add new car',
      ),
    );
  }
}

class NoUserCarsFoundBody extends StatelessWidget {
  const NoUserCarsFoundBody({
    super.key,
    required this.theme,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'There is no cars for you',
          style: theme.headlineSmall,
        ),
        SizedBox(
            width: 250,
            // height: 500,
            child: Image.asset(ImageAsset.noItems)),
        PrimaryButton(
          onPressed: () => Get.toNamed(CarOwnerRoutes.addNewCar),
          textButton: 'Add new car',
        )
      ],
    );
  }
}
