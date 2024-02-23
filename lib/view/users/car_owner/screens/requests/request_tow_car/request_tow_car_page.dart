
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/buttons_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/drawer.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/get_current_location_button.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/loading_page_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/map_widget_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RequestTowCarPage extends StatelessWidget {
  const RequestTowCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<DrawerControllerState> drawerKey =
        GlobalKey<DrawerControllerState>();

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
                        key: scaffoldKey,
                        drawer: TowCarOwnerHomePageDrawer(drawerKey: drawerKey),
                        body: PageBodyBuilder(
                            mapController: mapController,
                            initialMarker: initialMarker,
                            scaffoldKey: scaffoldKey,
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
    required this.scaffoldKey,
    required this.cubit,
  });

  final MapController mapController;
  final LatLng initialMarker;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final RequestTowCarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MapWidgetBuilder(
            mapController: mapController, initialMarker: initialMarker),
        ButtonsBuilder(
            scaffoldKey: scaffoldKey,
            cubit: cubit,
            mapController: mapController,
            initialMarker: initialMarker)
      ],
    );
  }
}







