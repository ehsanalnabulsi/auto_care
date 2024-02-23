part of 'create_maintenance_request_cubit.dart';

class CreateMaintenanceRequestState {}

class CreateMaintenanceRequestInitial extends CreateMaintenanceRequestState {}

class GetUserCarsLoadingState extends CreateMaintenanceRequestState {}

class GetUserCarsSuccessState extends CreateMaintenanceRequestState {}

class GetUserCarsErrorState extends CreateMaintenanceRequestState {}

class UpdateSelectedWorkshopState extends CreateMaintenanceRequestState {}

class GetWorkshopsLoadingState extends CreateMaintenanceRequestState {}

class GetWorkshopsSuccessState extends CreateMaintenanceRequestState {
  final dynamic response;
  GetWorkshopsSuccessState(this.response);
}

class GetWorkshopsErrorState extends CreateMaintenanceRequestState {
  final String? error;
  GetWorkshopsErrorState(this.error);
}

class CreateMaintenanceRequestLoadingState
    extends CreateMaintenanceRequestState {}

class CreateMaintenanceRequestSuccessState
    extends CreateMaintenanceRequestState {
  final dynamic response;
  CreateMaintenanceRequestSuccessState(this.response);
}

class CreateMaintenanceRequestErrorState extends CreateMaintenanceRequestState {
  final String? error;
  CreateMaintenanceRequestErrorState(this.error);
}
