import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'request_tow_car_state.dart';

class RequestTowCarCubit extends Cubit<RequestTowCarState> {
  RequestTowCarCubit() : super(RequestTowCarInitial());
  static RequestTowCarCubit get(context) => BlocProvider.of(context);
  late LocationData locationData;
  List availableTowCars = [];
  LatLng currentLocation = LatLng(0, 0);
  LatLng destinationLocation = const LatLng(0, 0);

  List<Marker> markers = [];
  Future<void>? createTowCarRequest({
    required LatLng currentLocation,
    required LatLng destinationLocation,
  }) async {
    emit(CreateTowCarRequestLoadingState());
    FormData formData = FormData.fromMap({
      'currentLocation': currentLocation,
      'destination': destinationLocation,
      'requestType': 2
    });
    final response = DioHelper.postForm(createTowRequestURL, data: formData);
    print(response);
    emit(CreateTowCarRequestSuccessState(locationData));
  }

  Future<void>? getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    locationData = await LocationService.getCurrentLocation();
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    markers.add(Marker(
      point: currentLocation,
      child: Transform.translate(
        offset: const Offset(-35, -50),
        child: const Icon(
          Icons.location_on,
          size: 75,
          color: AppColors.secondaryColor,
        ),
      ),
    ));
    emit(GetCurrentLocationSuccessState(locationData));
  }

  Future<void>? getWorkshops() async {
    emit(GetCurrentLocationLoadingState());
    locationData = await LocationService.getCurrentLocation();
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    markers.add(Marker(
      point: currentLocation,
      child: Transform.translate(
        offset: const Offset(-35, -50),
        child: const Icon(
          Icons.location_on,
          size: 75,
          color: AppColors.secondaryColor,
        ),
      ),
    ));
    emit(GetCurrentLocationSuccessState(locationData));
  }

  Future<void>? getAvailableTowCars() async {
    emit(GetCurrentLocationLoadingState());
    final LocationData locationData =
        await LocationService.getCurrentLocation();
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    emit(GetCurrentLocationSuccessState(locationData));
  }

  void getDestinationPoint(TapPosition tapPosition, LatLng newLocation) async {
    try {
      emit(GetDestinationPointLoadingState());
      print(destinationLocation);
      destinationLocation = newLocation;
      if (markers.length == 2) {
        markers.removeLast();
        markers.add(Marker(
          point: destinationLocation,
          child: Transform.translate(
            offset: const Offset(-25, -50),
            child: const Icon(
              Icons.location_on,
              size: 75,
              color: AppColors.secondaryColor,
            ),
          ),
        ));
      } else {
        markers.add(Marker(
          point: destinationLocation,
          child: Transform.translate(
            offset: const Offset(-25, -50),
            child: const Icon(
              Icons.location_on,
              size: 75,
              color: AppColors.secondaryColor,
            ),
          ),
        ));
      }

      emit(GetDestinationPointSuccessState(locationData));
    } catch (e) {
      emit(GetCurrentLocationErrorState());
    }
  }
}
