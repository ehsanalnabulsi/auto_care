import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/get_current_location_button.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/loading_page_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/car_owner_requests/request_tow_car_pages/request_tow_car_main_page/map_widget_builder.dart';
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
                          title: Text('Request Tow Car'),
                        ),
                        body: PageBodyBuilder(
                            mapController: mapController,
                            initialMarker: initialMarker,
                            cubit: cubit)),
                  ));
        },
      ),
    );
  }
}

class PageBodyBuilder extends StatelessWidget {
  const PageBodyBuilder({
    super.key,
    required this.mapController,
    required this.initialMarker,
    required this.cubit,
  });

  final MapController mapController;
  final LatLng initialMarker;

  final RequestTowCarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MapWidgetBuilder(
            mapController: mapController, initialMarker: initialMarker),
        PrimaryButton(onPressed: () {}, textButton: 'Order Now')
      ],
    );
  }
}
