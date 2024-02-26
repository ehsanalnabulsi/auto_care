part of 'add_new_car_cubit.dart';

class AddNewCarState {}

class AddNewCarInitial extends AddNewCarState {}

class AddNewCarLoadingState extends AddNewCarState {}

class AddNewCarSuccessState extends AddNewCarState {
  final Response response;
  AddNewCarSuccessState(this.response);
}

class AddNewCarErrorState extends AddNewCarState {
  final String? error;
  AddNewCarErrorState(this.error);
}

class GetOriginsLoadingState extends AddNewCarState {}

class GetOriginsSuccessState extends AddNewCarState {}

class GetOriginsErrorState extends AddNewCarState {}

class GetBrandsLoadingState extends AddNewCarState {}

class GetBrandsSuccessState extends AddNewCarState {}

class GetBrandsErrorState extends AddNewCarState {}

class GetCarModelsLoadingState extends AddNewCarState {}

class GetCarModelsSuccessState extends AddNewCarState {}

class GetCarModelsErrorState extends AddNewCarState {}

class SelectOriginUpdateState extends AddNewCarState {}

class SelectBrandUpdateState extends AddNewCarState {}

class PickAvatarLoadingState extends AddNewCarState {}

class PickAvatarSuccessState extends AddNewCarState {}

class PickAvatarErrorState extends AddNewCarState {}

