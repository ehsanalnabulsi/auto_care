import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/register/workshop_owner/register_workshop_owner_cubit.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class AddWorkshopLocationPage extends StatelessWidget {
  const AddWorkshopLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    LocationData locationData = Get.arguments;
    LatLng initialMarker =
        LatLng(locationData.latitude!, locationData.longitude!);
    return BlocConsumer<RegisterWorkshopOwnerCubit, RegisterWorkshopOwnerState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<RegisterWorkshopOwnerCubit>();
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, newLocation) {
                  cubit.updateLocation(tapPosition, newLocation);
                  // mapController.move(newLocation, 15.0);
                },
                backgroundColor: AppColors.greyColor,
                initialZoom: 15.0,
                initialCenter: initialMarker,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                ConditionalBuilder(
                    condition:
                        state is UpdateWorkshopLocationLocationSuccessState,
                    fallback: (context) => MarkerLayer(markers: [
                          Marker(
                            // key: ,
                            point: initialMarker,
                            child: const Icon(
                              Icons.location_on,
                              size: 75,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ]),
                    builder: (context) => MarkerLayer(markers: [
                          Marker(
                            // key: ,
                            point: cubit.workshopLocation,
                            child: Transform.translate(
                              offset: const Offset(-35, -50),
                              child: const Icon(
                                Icons.location_on,
                                size: 75,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ]))
              ],
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                      style: IconButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          elevation: 2,
                          iconSize: 36.0,
                          backgroundColor: AppColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryButton(
                      onPressed: () {
                        Get.back();
                      },
                      textButton: 'Save Workshop Location',
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
//  MyTextFormField(
//               hintText: cubit.address,
//               textInputType: TextInputType.none,
//               controller: TextEditingController())