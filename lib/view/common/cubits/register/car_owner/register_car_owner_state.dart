part of 'register_car_owner_cubit.dart';

class RegisterCarOwnerState {}

class RegisterCarOwnerInitial extends RegisterCarOwnerState {}

class RegisterPasswordVisibilityState extends RegisterCarOwnerState {}

class PickAvatarLoadingState extends RegisterCarOwnerState {}

class PickAvatarSuccessState extends RegisterCarOwnerState {}

class PickAvatarErrorState extends RegisterCarOwnerState {}

class RegisterCarOwnerLoadingState extends RegisterCarOwnerState {}

class RegisterCarOwnerSuccessState extends RegisterCarOwnerState {
  final Response response;
  RegisterCarOwnerSuccessState(this.response);
}

class RegisterCarOwnerErrorState extends RegisterCarOwnerState {
  final Response? errorResponse;
  RegisterCarOwnerErrorState(this.errorResponse);
}
