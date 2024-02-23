part of 'register_parts_supplier_cubit.dart';

class RegisterPartsSupplierState {}

class RegisterPartsSupplierInitial extends RegisterPartsSupplierState {}

class GetOriginsLoadingState extends RegisterPartsSupplierState {}

class GetOriginsSuccessState extends RegisterPartsSupplierState {}

class GetOriginsErrorState extends RegisterPartsSupplierState {}

class GetBrandsLoadingState extends RegisterPartsSupplierState {}

class GetBrandsSuccessState extends RegisterPartsSupplierState {}

class GetBrandsErrorState extends RegisterPartsSupplierState {}

class UpdateBrandsLoadingState extends RegisterPartsSupplierState {}

class UpdateBrandsSuccessState extends RegisterPartsSupplierState {}

class UpdateBrandsErrorState extends RegisterPartsSupplierState {}

class RegisterPasswordVisibilityState extends RegisterPartsSupplierState {}

class PickAvatarLoadingState extends RegisterPartsSupplierState {}

class PickAvatarSuccessState extends RegisterPartsSupplierState {}

class PickAvatarErrorState extends RegisterPartsSupplierState {}

class PickLogoLoadingState extends RegisterPartsSupplierState {}

class PickLogoSuccessState extends RegisterPartsSupplierState {}

class PickLogoErrorState extends RegisterPartsSupplierState {}

class RegisterPartsSupplierLoadingState extends RegisterPartsSupplierState {}

class RegisterPartsSupplierSuccessState extends RegisterPartsSupplierState {
  final Response<dynamic> response;
  RegisterPartsSupplierSuccessState(this.response);
}

class RegisterPartsSupplierErrorState extends RegisterPartsSupplierState {
  final Response? error;
  RegisterPartsSupplierErrorState(this.error);
}

class UpdateStoreLocationLocationLoadingState
    extends RegisterPartsSupplierState {}

class UpdateStoreLocationLocationSuccessState
    extends RegisterPartsSupplierState {}

class UpdateStoreLocationLocationErrorState
    extends RegisterPartsSupplierState {}


