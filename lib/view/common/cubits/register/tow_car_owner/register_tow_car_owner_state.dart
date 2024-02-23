part of 'register_tow_car_owner_cubit.dart';

class RegisterTowCarOwnerState {}

class RegisterTowCarOwnerInitial extends RegisterTowCarOwnerState {}

class GetCitiesLoadingState extends RegisterTowCarOwnerState {}

class GetCitiesSuccessState extends RegisterTowCarOwnerState {}

class GetCitiesErrorState extends RegisterTowCarOwnerState {}

class GetOriginsLoadingState extends RegisterTowCarOwnerState {}

class GetOriginsSuccessState extends RegisterTowCarOwnerState {}

class GetOriginsErrorState extends RegisterTowCarOwnerState {}

class GetBrandsLoadingState extends RegisterTowCarOwnerState {}

class GetBrandsSuccessState extends RegisterTowCarOwnerState {}

class GetBrandsErrorState extends RegisterTowCarOwnerState {}

class UpdateBrandLoadingState extends RegisterTowCarOwnerState {}

class UpdateBrandSuccessState extends RegisterTowCarOwnerState {}

class UpdateBrandErrorState extends RegisterTowCarOwnerState {}

class UpdateCityLoadingState extends RegisterTowCarOwnerState {}

class UpdateCitySuccessState extends RegisterTowCarOwnerState {}

class UpdateCityErrorState extends RegisterTowCarOwnerState {}

class RegisterPasswordVisibilityState extends RegisterTowCarOwnerState {}

class PickAvatarLoadingState extends RegisterTowCarOwnerState {}

class PickAvatarSuccessState extends RegisterTowCarOwnerState {}

class PickAvatarErrorState extends RegisterTowCarOwnerState {}

class PickLogoLoadingState extends RegisterTowCarOwnerState {}

class PickLogoSuccessState extends RegisterTowCarOwnerState {}

class PickLogoErrorState extends RegisterTowCarOwnerState {}

class RegisterTowCarOwnerLoadingState extends RegisterTowCarOwnerState {}

class RegisterTowCarOwnerSuccessState extends RegisterTowCarOwnerState {
  final Response<dynamic> response;
  RegisterTowCarOwnerSuccessState(this.response);
}

class RegisterTowCarOwnerErrorState extends RegisterTowCarOwnerState {
  final Response? error;
  RegisterTowCarOwnerErrorState(this.error);
}

class UpdateTowCarLocationLocationLoadingState
    extends RegisterTowCarOwnerState {}

class UpdateTowCarLocationLocationSuccessState
    extends RegisterTowCarOwnerState {}

class UpdateTowCarLocationLocationErrorState extends RegisterTowCarOwnerState {}

class UpdateModalLoadingState extends RegisterTowCarOwnerState {}

class UpdateModalSuccessState extends RegisterTowCarOwnerState {}

class UpdateModalErrorState extends RegisterTowCarOwnerState {}

class EncodeTowCarLocationLoading extends RegisterTowCarOwnerState {}

class EncodeTowCarLocationSuccess extends RegisterTowCarOwnerState {}

class EncodeTowCarLocationError extends RegisterTowCarOwnerState {}
