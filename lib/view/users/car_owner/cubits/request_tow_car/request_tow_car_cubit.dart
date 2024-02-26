import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'request_tow_car_state.dart';

class RequestTowCarCubit extends Cubit<RequestTowCarState> {
  RequestTowCarCubit() : super(RequestTowCarInitial());
  static RequestTowCarCubit get(context) => BlocProvider.of(context);
  late LocationData locationData;
  LatLng destinationLocation = const LatLng(0, 0);
  Future<void>? getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    locationData = await LocationService.getCurrentLocation();

    emit(GetCurrentLocationSuccessState(locationData));
  }

  Future<void>? getAvailableTowCars() async {
    emit(GetCurrentLocationLoadingState());
    final LocationData locationData =
        await LocationService.getCurrentLocation();
    emit(GetCurrentLocationSuccessState(locationData));
  }

  void getDestinationPoint(TapPosition tapPosition, LatLng newLocation) async {
    try {
      emit(GetDestinationPointLoadingState());

      destinationLocation = newLocation;

      emit(GetDestinationPointSuccessState(locationData));
    } catch (e) {
      emit(GetCurrentLocationErrorState());
    }
  }
}
