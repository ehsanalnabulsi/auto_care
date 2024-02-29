import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/get_current_location_button.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/loading_page_builder.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_map/flutter_map.dart';

class RequestTowCarPage extends StatelessWidget {
  const RequestTowCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();

    return BlocProvider(
      create: (context) => RequestTowCarCubit()..getCurrentLocation(),
      child: BlocConsumer<RequestTowCarCubit, RequestTowCarState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<RequestTowCarCubit>();
          return ConditionalBuilder(
              condition: state is GetCurrentLocationLoadingState,
              builder: (context) => const LoadingPageBuilder(),
              fallback: (context) => ConditionalBuilder(
                  condition: state is GetCurrentLocationSuccessState ||
                      state is GetDestinationPointSuccessState,
                  fallback: (context) => GetCurrentLocationButton(cubit: cubit),
                  builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Request Tow Car'),
                        ),
                        body: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Select Workshop'),
                                        fillColor: AppColors.whiteColor,
                                        filled: true),
                                    items: ['asd', 'asd']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {}),
                                PrimaryButton(
                                    onPressed: () {
                                      cubit.createTowCarRequest(
                                          currentLocation:
                                              cubit.currentLocation,
                                          destinationLocation:
                                              cubit.destinationLocation);
                                    },
                                    textButton: 'Order Now'),
                              ],
                            )
                          ],
                        ),
                      )));
        },
      ),
    );
  }
}
