import 'package:auto_care/core/services/location.dart';
import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'request_tow_car_state.dart';

class RequestTowCarCubit extends Cubit<RequestTowCarState> {
  RequestTowCarCubit() : super(RequestTowCarInitial());

   Future<void>? getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    final LocationData locationData =
        await LocationService.getCurrentLocation();
    emit(GetCurrentLocationSuccessState(locationData));
  }


}
