part of 'add_new_product_cubit.dart';

class AddNewProductState {}

class AddNewProductInitial extends AddNewProductState {}

class AddNewProductLoadingState extends AddNewProductState {}

class AddNewProductSuccessState extends AddNewProductState {
  final Response response;
  AddNewProductSuccessState(this.response);
}

class AddNewProductErrorState extends AddNewProductState {
  final String? error;
  AddNewProductErrorState(this.error);
}

class GetBrandsLoadingState extends AddNewProductState {}

class GetBrandsSuccessState extends AddNewProductState {}

class GetBrandsErrorState extends AddNewProductState {}

class GetCarModelsLoadingState extends AddNewProductState {}

class GetCarModelsSuccessState extends AddNewProductState {}

class GetCarModelsErrorState extends AddNewProductState {}

class UpdateSelectedCarModelsLoadingState extends AddNewProductState {}

class UpdateSelectedCarModelsSuccessState extends AddNewProductState {}

class UpdateSelectedCarModelsErrorState extends AddNewProductState {}

class GetProductsLoadingState extends AddNewProductState {}

class GetProductsSuccessState extends AddNewProductState {}

class GetProductsErrorState extends AddNewProductState {}

class UpdateSelectedProductsLoadingState extends AddNewProductState {}

class UpdateSelectedProductsSuccessState extends AddNewProductState {}

class UpdateSelectedProductsErrorState extends AddNewProductState {}
