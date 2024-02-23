import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:location/location.dart';

part 'request_tow_car_state.dart';

class RequestTowCarCubit extends Cubit<RequestTowCarState> {
  RequestTowCarCubit() : super(RequestTowCarInitial());
  static RequestTowCarCubit get(context) => BlocProvider.of(context);
  late LocationData locationData;
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
}
