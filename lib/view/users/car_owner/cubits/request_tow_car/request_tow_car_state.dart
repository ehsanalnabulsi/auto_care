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

class GetUserCarsLoadingState extends RequestTowCarState {}

class GetUserCarsSuccessState extends RequestTowCarState {}

class GetUserCarsErrorState extends RequestTowCarState {}

class GetWorkshopsByBrandIdLoadingState extends RequestTowCarState {}

class GetWorkshopsByBrandIdSuccessState extends RequestTowCarState {}

class GetWorkshopsByBrandIdErrorState extends RequestTowCarState {}

class CreateTowCarRequestErrorState extends RequestTowCarState {}

class GetDestinationPointLoadingState extends RequestTowCarState {}

class GetDestinationPointSuccessState extends RequestTowCarState {
  final LocationData locationData;
  GetDestinationPointSuccessState(this.locationData);
}

class GetDestinationPointErrorState extends RequestTowCarState {}




class CreateMaintenanceRequestInitial extends RequestTowCarState {}


class UpdateSelectedWorkshopState extends RequestTowCarState {}

class GetWorkshopsLoadingState extends RequestTowCarState {}

class GetWorkshopsSuccessState extends RequestTowCarState {
  final dynamic response;
  GetWorkshopsSuccessState(this.response);
}

class GetWorkshopsErrorState extends RequestTowCarState {
  final String? error;
  GetWorkshopsErrorState(this.error);
}

class CreateMaintenanceRequestLoadingState
    extends RequestTowCarState {}

class CreateMaintenanceRequestSuccessState
    extends RequestTowCarState {
  final dynamic response;
  CreateMaintenanceRequestSuccessState(this.response);
}

class CreateMaintenanceRequestErrorState extends RequestTowCarState {
  final DioException? error;
  CreateMaintenanceRequestErrorState(this.error);
}
