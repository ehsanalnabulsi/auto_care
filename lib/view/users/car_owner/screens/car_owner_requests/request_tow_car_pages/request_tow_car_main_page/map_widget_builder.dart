import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidgetBuilder extends StatelessWidget {
  const MapWidgetBuilder({
    super.key,
    required this.mapController,
    required this.initialMarker,
  });

  final MapController mapController;
  final LatLng initialMarker;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onTap: (tapPosition, newLocation) {
          // cubit.updateLocation(tapPosition, newLocation);
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
            // key: ,
            point: initialMarker,
            child: Transform.translate(
              offset: const Offset(-35, 70),
              child: const Icon(
                Icons.location_on,
                size: 75,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
