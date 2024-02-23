import 'package:auto_care/core/constant/imports.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapBuilder extends StatelessWidget {
  const MapBuilder({
    super.key,
    required this.currentLocation,
  });

  final LatLng currentLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: double.maxFinite,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.primaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: FlutterMap(
            options: MapOptions(
              backgroundColor: AppColors.greyColor,
              initialZoom: 18.0,
              initialCenter: currentLocation,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(markers: [
                Marker(
                    point: currentLocation,
                    child: const Icon(
                      Icons.location_on,
                      size: 36,
                      color: AppColors.primaryColor,
                    ))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
