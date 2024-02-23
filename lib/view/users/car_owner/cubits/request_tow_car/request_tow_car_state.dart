part of 'request_tow_car_cubit.dart';

@immutable
sealed class RequestTowCarState {}

final class RequestTowCarInitial extends RequestTowCarState {}

class GetCurrentLocationLoadingState extends RequestTowCarState {}

class GetCurrentLocationSuccessState extends RequestTowCarState {
  final LocationData locationData;
  GetCurrentLocationSuccessState(this.locationData);
}

class GetCurrentLocationErrorState extends RequestTowCarState {}
