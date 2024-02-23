import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/view/common/cubits/register/parts_supplier/register_parts_supplier_cubit.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class AddStoreLocationPage extends StatelessWidget {
  const AddStoreLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    LocationData locationData = Get.arguments;
    LatLng initialMarker =
        LatLng(locationData.latitude!, locationData.longitude!);
    return BlocConsumer<RegisterPartsSupplierCubit, RegisterPartsSupplierState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = RegisterPartsSupplierCubit.get(context);
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
                    condition: state is UpdateStoreLocationLocationSuccessState,
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
                            point: cubit.storeLocation,

                            child: Transform.translate(
                              offset: const Offset(-35, -50),
                              child: const Icon(
                                Icons.location_on,
                                size: 75,
                                color: AppColors.primaryColor,
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
                      textButton: 'Save Store Location',
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
