import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/get_current_location_button.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/loading_page_builder.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
          LatLng initialMarker = const LatLng(0, 0);
          if (state is GetCurrentLocationSuccessState) {
            initialMarker = LatLng(
                state.locationData.latitude!, state.locationData.longitude!);
          }
          var cubit = context.read<RequestTowCarCubit>();
          return ConditionalBuilder(
              condition: state is GetCurrentLocationLoadingState,
              builder: (context) => const LoadingPageBuilder(),
              fallback: (context) => ConditionalBuilder(
                    condition: state is GetCurrentLocationErrorState,
                    builder: (context) =>
                        GetCurrentLocationButton(cubit: cubit),
                    fallback: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Request Tow Car'),
                        ),
                        body: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            MapWidgetBuilder(
                                mapController: mapController,
                                initialMarker: initialMarker,
                                state: state,
                                cubit: cubit),
                            PrimaryButton(
                                onPressed: () {}, textButton: 'Order Now')
                          ],
                        )),
                  ));
        },
      ),
    );
  }
}

class MapWidgetBuilder extends StatelessWidget {
  const MapWidgetBuilder({
    super.key,
    required this.mapController,
    required this.initialMarker,
    required this.cubit,
    required this.state,
  });

  final MapController mapController;
  final LatLng initialMarker;
  final RequestTowCarCubit cubit;
  final dynamic state;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (tapPosition, newLocation) {
          cubit.getDestinationPoint(tapPosition, newLocation);
        },
        backgroundColor: AppColors.greyColor,
        initialZoom: 18.0,
        initialCenter: initialMarker,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(markers: [
          Marker(
            point: cubit.destinationLocation,
            child: const Icon(
              Icons.location_on,
              size: 75,
              color: AppColors.primaryColor,
            ),
          ),
          
        ]),
        MarkerLayer(markers: [
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
      ],
    );
  }
}
