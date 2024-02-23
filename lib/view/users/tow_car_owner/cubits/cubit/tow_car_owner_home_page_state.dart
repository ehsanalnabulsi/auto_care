part of 'tow_car_owner_home_page_cubit.dart';

class TowCarOwnerHomePageState {}

class TowCarOwnerHomePageInitial extends TowCarOwnerHomePageState {}

class GetCurrentLocationLoadingState extends TowCarOwnerHomePageState {}

class GetCurrentLocationSuccessState extends TowCarOwnerHomePageState {
  final LocationData locationData;
  GetCurrentLocationSuccessState(this.locationData);
}

class GetCurrentLocationErrorState extends TowCarOwnerHomePageState {}

class ChangeStatusState extends TowCarOwnerHomePageState {}
