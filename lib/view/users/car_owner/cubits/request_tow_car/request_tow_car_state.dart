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

class CreateTowCarRequestLoadingState extends RequestTowCarState {}

class CreateTowCarRequestSuccessState extends RequestTowCarState {
  final LocationData locationData;
  CreateTowCarRequestSuccessState(this.locationData);
}

class CreateTowCarRequestErrorState extends RequestTowCarState {}

class GetDestinationPointLoadingState extends RequestTowCarState {}

class GetDestinationPointSuccessState extends RequestTowCarState {
  final LocationData locationData;
  GetDestinationPointSuccessState(this.locationData);
}

class GetDestinationPointErrorState extends RequestTowCarState {}
