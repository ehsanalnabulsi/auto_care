import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class AddDestinationLocationPage extends StatelessWidget {
  const AddDestinationLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();

    return BlocConsumer<RequestTowCarCubit, RequestTowCarState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<RequestTowCarCubit>();
        return FutureBuilder(
            future: Future.delayed(Duration(seconds: 5)),
            builder: (context, snapshot) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        onTap: (tapPosition, newLocation) {
                          cubit.getDestinationPoint(tapPosition, newLocation);
                          // mapController.move(newLocation, 15.0);
                        },
                        backgroundColor: AppColors.greyColor,
                        initialZoom: 15.0,
                        initialCenter: cubit.currentLocation,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        MarkerLayer(markers: cubit.markers),
                        PolylineLayer(polylines: [
                          Polyline(strokeJoin: StrokeJoin.round, points: [
                            cubit.currentLocation,
                            cubit.destinationLocation
                          ])
                        ])
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
                              textButton: 'Save Destination Location',
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
      },
    );
  }
}
