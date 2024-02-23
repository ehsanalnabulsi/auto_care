import 'package:location/location.dart';

class LocationService {
  static Location location = Location();
  late LocationData currentLocation;

  static Future<void> checkPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Registration cannot continue
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {}
    }
  }

  Future<void> updateLocation() async {
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      throw Exception('Error getting location: $e');
    }
  }

  static Future<LocationData> getCurrentLocation() async {
    try {
      await checkPermission();
      return await location.getLocation();
    } catch (e) {
      throw Exception('Error getting location: $e');
    }
  }
}
