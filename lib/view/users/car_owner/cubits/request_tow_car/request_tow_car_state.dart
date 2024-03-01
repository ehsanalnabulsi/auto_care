part of 'request_tow_car_cubit.dart';

class RequestTowCarState {}

class RequestTowCarInitial extends RequestTowCarState {}

class GetCurrentLocationLoadingState extends RequestTowCarState {}

class GetCurrentLocationSuccessState extends RequestTowCarState {
  final LocationData locationData;
  GetCurrentLocationSuccessState(this.locationData);
}

class GetCurrentLocationErrorState extends RequestTowCarState {}

class CreateTowCarRequestLoadingState extends RequestTowCarState {}

class CreateTowCarRequestSuccessState extends RequestTowCarState {
  final Future<Response<dynamic>>? response;
  CreateTowCarRequestSuccessState(this.response);
}

class CreateTowCarRequestErrorState extends RequestTowCarState {
  final String? error;
  CreateTowCarRequestErrorState(this.error);
}

class GetUserCarsLoadingState extends RequestTowCarState {}

class GetUserCarsSuccessState extends RequestTowCarState {}

class GetUserCarsErrorState extends RequestTowCarState {}

class GetWorkshopsByBrandIdLoadingState extends RequestTowCarState {}

class GetWorkshopsByBrandIdSuccessState extends RequestTowCarState {}

class GetWorkshopsByBrandIdErrorState extends RequestTowCarState {}

class GetDestinationPointLoadingState extends RequestTowCarState {}

class GetDestinationPointSuccessState extends RequestTowCarState {
  final LocationData locationData;
  GetDestinationPointSuccessState(this.locationData);
}

class GetDestinationPointErrorState extends RequestTowCarState {}

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

class GetAvailableTowCarsLoadingState extends RequestTowCarState {}

class GetAvailableTowCarsSuccessState extends RequestTowCarState {
  final dynamic response;
  GetAvailableTowCarsSuccessState(this.response);
}

class GetAvailableTowCarsErrorState extends RequestTowCarState {
  final String? error;
  GetAvailableTowCarsErrorState(this.error);
}
