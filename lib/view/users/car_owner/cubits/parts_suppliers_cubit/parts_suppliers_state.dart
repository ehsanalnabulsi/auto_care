import 'package:dio/dio.dart';

class PartsSuppliersState {}

class PartsSuppliersInitialState extends PartsSuppliersState {}

class UpdateIsSearchingState extends PartsSuppliersState {}

class GetPartsSuppliersLoadingState extends PartsSuppliersState {}

class GetPartsSuppliersSuccessState extends PartsSuppliersState {
  final Response response;
  GetPartsSuppliersSuccessState(this.response);
}

class GetPartsSuppliersErrorState extends PartsSuppliersState {
  final String? error;
  GetPartsSuppliersErrorState(this.error);
}

class GetPartsSupplierProductsLoadingState extends PartsSuppliersState {}

class GetPartsSupplierProductsSuccessState extends PartsSuppliersState {
  final Response response;
  GetPartsSupplierProductsSuccessState(this.response);
}

class GetPartsSupplierProductsErrorState extends PartsSuppliersState {
  final String? error;
  GetPartsSupplierProductsErrorState(this.error);
}

class UpdateSelectedCategory extends PartsSuppliersState {}

class GetSpecialistsLoadingState extends PartsSuppliersState {}

class GetSpecialistsSuccessState extends PartsSuppliersState {
  final Response response;
  GetSpecialistsSuccessState(this.response);
}

class GetSpecialistsErrorState extends PartsSuppliersState {
  final String? error;
  GetSpecialistsErrorState(this.error);
}
