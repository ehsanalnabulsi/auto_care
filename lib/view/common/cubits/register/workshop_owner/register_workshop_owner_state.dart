part of 'register_workshop_owner_cubit.dart';

class RegisterWorkshopOwnerState {}

class RegisterWorkshopOwnerInitial extends RegisterWorkshopOwnerState {}

class GetSpecialistsLoadingState extends RegisterWorkshopOwnerState {}

class GetSpecialistsSuccessState extends RegisterWorkshopOwnerState {}

class GetSpecialistsErrorState extends RegisterWorkshopOwnerState {}

class GetOriginsLoadingState extends RegisterWorkshopOwnerState {}

class GetOriginsSuccessState extends RegisterWorkshopOwnerState {}

class GetOriginsErrorState extends RegisterWorkshopOwnerState {}

class GetBrandsLoadingState extends RegisterWorkshopOwnerState {}

class GetBrandsSuccessState extends RegisterWorkshopOwnerState {}

class GetBrandsErrorState extends RegisterWorkshopOwnerState {}

class UpdateBrandsLoadingState extends RegisterWorkshopOwnerState {}

class UpdateBrandsSuccessState extends RegisterWorkshopOwnerState {}

class UpdateBrandsErrorState extends RegisterWorkshopOwnerState {}

class UpdateSpecialistLoadingState extends RegisterWorkshopOwnerState {}

class UpdateSpecialistSuccessState extends RegisterWorkshopOwnerState {}

class UpdateSpecialistErrorState extends RegisterWorkshopOwnerState {}

class RegisterPasswordVisibilityState extends RegisterWorkshopOwnerState {}

class PickAvatarLoadingState extends RegisterWorkshopOwnerState {}

class PickAvatarSuccessState extends RegisterWorkshopOwnerState {}

class PickAvatarErrorState extends RegisterWorkshopOwnerState {}

class PickLogoLoadingState extends RegisterWorkshopOwnerState {}

class PickLogoSuccessState extends RegisterWorkshopOwnerState {}

class PickLogoErrorState extends RegisterWorkshopOwnerState {}

class RegisterWorkshopOwnerLoadingState extends RegisterWorkshopOwnerState {}

class RegisterWorkshopOwnerSuccessState extends RegisterWorkshopOwnerState {
  final Response<dynamic> response;
  RegisterWorkshopOwnerSuccessState(this.response);
}

class RegisterWorkshopOwnerErrorState extends RegisterWorkshopOwnerState {
  final Response? error;
  RegisterWorkshopOwnerErrorState(this.error);
}

class UpdateWorkshopLocationLocationLoadingState
    extends RegisterWorkshopOwnerState {}

class UpdateWorkshopLocationLocationSuccessState
    extends RegisterWorkshopOwnerState {}

class UpdateWorkshopLocationLocationErrorState
    extends RegisterWorkshopOwnerState {}

class UpdateModalLoadingState extends RegisterWorkshopOwnerState {}

class UpdateModalSuccessState extends RegisterWorkshopOwnerState {}

class UpdateModalErrorState extends RegisterWorkshopOwnerState {}

class EncodeWorkshopLocationLoading extends RegisterWorkshopOwnerState {}

class EncodeWorkshopLocationSuccess extends RegisterWorkshopOwnerState {}

class EncodeWorkshopLocationError extends RegisterWorkshopOwnerState {}
