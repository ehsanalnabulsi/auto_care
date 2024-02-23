part of 'car_owner_home_page_cubit.dart';

class CarOwnerHomePageState {}

class CarOwnerHomePageInitialState extends CarOwnerHomePageState {}

class GetSliderImagesLoadingState extends CarOwnerHomePageState {}

class GetSliderImagesSuccessState extends CarOwnerHomePageState {}

class GetSliderImagesErrorState extends CarOwnerHomePageState {}

class GetWorkshopsLoadingState extends CarOwnerHomePageState {}

class GetWorkshopsSuccessState extends CarOwnerHomePageState {
  final Response response;
  GetWorkshopsSuccessState(this.response);
}

class GetWorkshopsErrorState extends CarOwnerHomePageState {}

class GetPartsSuppliersLoadingState extends CarOwnerHomePageState {}

class GetPartsSuppliersSuccessState extends CarOwnerHomePageState {
  final Response response;
  GetPartsSuppliersSuccessState(this.response);
}

class GetPartsSuppliersErrorState extends CarOwnerHomePageState {
  final String? error;
  GetPartsSuppliersErrorState(this.error);
}

class GetDataLoadingState extends CarOwnerHomePageState {}

class GetDataSuccessState extends CarOwnerHomePageState {}

class GetDataErrorState extends CarOwnerHomePageState {}

class UpdateSelectedTagState extends CarOwnerHomePageState {}
