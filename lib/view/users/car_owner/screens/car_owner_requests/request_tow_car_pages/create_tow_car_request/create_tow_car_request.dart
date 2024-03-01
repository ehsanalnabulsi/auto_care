import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:select_card/select_card.dart';

class CreateTowCarRequest extends StatelessWidget {
  const CreateTowCarRequest({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    return BlocProvider(
      create: (context) => RequestTowCarCubit()..getUserCars(),
      child: BlocConsumer<RequestTowCarCubit, RequestTowCarState>(
        listener: (context, state) async {
          // if (state is CreateMaintenanceRequestSuccessState) {
          //   if (state.response.statusCode == 200) {
          //     final snackBar = SnackBar(
          //       duration: const Duration(seconds: 3),
          //       elevation: 1,
          //       behavior: SnackBarBehavior.fixed,
          //       backgroundColor: Colors.transparent,
          //       content: AwesomeSnackbarContent(
          //         title: 'Request Sent',
          //         message: '${state.response.statusMessage}',
          //         contentType: ContentType.success,
          //       ),
          //     );
          //     // CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
          //     ScaffoldMessenger.of(context)
          //       ..hideCurrentSnackBar()
          //       ..showSnackBar(snackBar);
          //     Get.toNamed(CarOwnerRoutes.carOwnerMainPage, arguments: 2);
          //   }
          // } else if (state is CreateMaintenanceRequestErrorState) {
          //   final snackBar = SnackBar(
          //     duration: const Duration(seconds: 3),
          //     elevation: 0,
          //     behavior: SnackBarBehavior.floating,
          //     backgroundColor: Colors.transparent,
          //     content: AwesomeSnackbarContent(
          //       title: 'Something went wrong',
          //       message: '${state.error}',
          //       contentType: ContentType.failure,
          //     ),
          //   );
          //   ScaffoldMessenger.of(context)
          //     ..hideCurrentSnackBar()
          //     ..showSnackBar(snackBar);
          // }
        },
        builder: (context, state) {
          var cubit = RequestTowCarCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Maintenance'),
            ),
            body: SingleChildScrollView(
                child: Form(
              child: ConditionalBuilder(
                  condition: state is GetUserCarsSuccessState &&
                      cubit.userCars.isEmpty,
                  builder: (context) => Center(
                        child: TextButton.icon(
                          icon: const Icon(
                            Icons.add,
                            size: 35,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            Get.toNamed(CarOwnerRoutes.addNewCar);
                          },
                          label: const Text(
                            'Dont Have Requests , Go to Add New Car',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                  fallback: (context) => ConditionalBuilder(
                        condition: state is GetUserCarsLoadingState,
                        builder: (context) => const Center(
                          child: AppProgressIndicator(),
                        ),
                        fallback: (context) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SelectGroupCard(context,
                                  titles: cubit.userCarsNames,
                                  contents: cubit.userCarsPlatesNumber,
                                  imageSourceType: ImageSourceType.network,
                                  images: cubit.userCarsImages,
                                  titleTextColor: AppColors.primaryColor,
                                  contentTextColor: Colors.black,
                                  cardBackgroundColor: AppColors.greyColor,
                                  cardSelectedColor: AppColors.primaryColor,
                                  // radius: 5,
                                  ids: cubit.userCarsIds, onTap: (title, id) {
                                cubit.getWorkshopsByCarModel(id);
                                debugPrint(id);
                                debugPrint(title);
                              }),
                            ),
                            ConditionalBuilder(
                                condition: state is GetWorkshopsSuccessState ||
                                    state is UpdateSelectedWorkshopState,
                                builder: (context) => CustomDropDownButton(
                                      hint: 'Select Workshop',
                                      onChanged: (value) {
                                        cubit.updateSelectedWorkshop(value);
                                      },
                                      items: cubit.workshopsNames,
                                    ),
                                fallback: (context) => const SizedBox()),
                            FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                onTap: (tapPosition, newLocation) {
                                  cubit.getDestinationPoint(
                                      tapPosition, newLocation);
                                },
                                backgroundColor: AppColors.greyColor,
                                initialZoom: 18.0,
                                initialCenter: cubit.currentLocation,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  subdomains: const ['a', 'b', 'c'],
                                ),
                                PolylineLayer(polylines: [
                                  Polyline(
                                      strokeWidth: 5,
                                      color: AppColors.primaryColor,
                                      points: [
                                        cubit.currentLocation,
                                        cubit.destinationLocation
                                      ])
                                ]),
                                MarkerLayer(markers: cubit.markers),
                              ],
                            ),
                            ConditionalBuilder(
                                condition: state
                                    is CreateMaintenanceRequestLoadingState,
                                builder: (context) =>
                                    const AppProgressIndicator(),
                                fallback: (context) => PrimaryButton(
                                    onPressed: () {
                                      if (cubit.selectedCar != null &&
                                          cubit.selectedWorkshop != null) {
                                        cubit.createTowCarRequest(
                                            carId: cubit.selectedCar!,
                                            currentLocation:
                                                cubit.currentLocation,
                                            destinationLocation:
                                                cubit.destinationLocation);
                                      }
                                    },
                                    textButton: 'Send Request'))
                          ],
                        ),
                      )),
            )),
          );
        },
      ),
    );
  }
}
