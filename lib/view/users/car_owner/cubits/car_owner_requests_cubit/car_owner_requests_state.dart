part of 'car_owner_requests_cubit.dart';

class CarOwnerRequestsState {}

class RequestsPageInitial extends CarOwnerRequestsState {}

class GetUserRequestsLoadingState extends CarOwnerRequestsState {}

class GetUserRequestsSuccessState extends CarOwnerRequestsState {}

class GetUserRequestsErrorState extends CarOwnerRequestsState {}

class CancelMaintenanceRequestLoadingState extends CarOwnerRequestsState {}

class CancelMaintenanceRequestSuccessState extends CarOwnerRequestsState {
  final Response response;
  CancelMaintenanceRequestSuccessState(this.response);
}

class CancelMaintenanceRequestErrorState extends CarOwnerRequestsState {
  final error;
  CancelMaintenanceRequestErrorState(this.error);
}

class AcceptMaintenanceAppointmentLoadingState extends CarOwnerRequestsState {}

class AcceptMaintenanceAppointmentSuccessState extends CarOwnerRequestsState {
  final Response response;
  AcceptMaintenanceAppointmentSuccessState(this.response);
}

class AcceptMaintenanceAppointmentErrorState extends CarOwnerRequestsState {
  final error;
  AcceptMaintenanceAppointmentErrorState(this.error);
}
