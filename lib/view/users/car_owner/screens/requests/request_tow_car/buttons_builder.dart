import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/open_drawer_and_change_status_buttons.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car/update_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ButtonsBuilder extends StatelessWidget {
  const ButtonsBuilder({
    super.key,
    required this.scaffoldKey,
    required this.cubit,
    required this.mapController,
    required this.initialMarker,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final RequestTowCarCubit cubit;
  final MapController mapController;
  final LatLng initialMarker;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OpenDrawerAndChangeStatusButtons(
              scaffoldKey: scaffoldKey, cubit: cubit),
          UpdateMapView(
              mapController: mapController, initialMarker: initialMarker)
        ],
      ),
    );
  }
}
