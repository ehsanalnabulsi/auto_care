import 'package:auto_care/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class UpdateMapView extends StatelessWidget {
  const UpdateMapView({
    super.key,
    required this.mapController,
    required this.initialMarker,
  });

  final MapController mapController;
  final LatLng initialMarker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
          mapController.move(initialMarker, 18);
        },
        style: IconButton.styleFrom(backgroundColor: AppColors.whiteColor),
        icon: const Icon(
          Icons.navigation,
          size: 30,
        ),
      ),
    );
  }
}
