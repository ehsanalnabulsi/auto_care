part of 'workshop_owner_requests_cubit.dart';

class WorkshopOwnerRequestsState {}

class WorkshopOwnerRequestsInitial extends WorkshopOwnerRequestsState {}

class GetUserRequestsLoadingState extends WorkshopOwnerRequestsState {}

class GetUserRequestsSuccessState extends WorkshopOwnerRequestsState {}

class GetUserRequestsErrorState extends WorkshopOwnerRequestsState {}

class CancelMaintenanceRequestLoadingState extends WorkshopOwnerRequestsState {}

class CancelMaintenanceRequestSuccessState extends WorkshopOwnerRequestsState {
  final Response response;
  CancelMaintenanceRequestSuccessState(this.response);
}

class CancelMaintenanceRequestErrorState extends WorkshopOwnerRequestsState {
  final error;
  CancelMaintenanceRequestErrorState(this.error);
}

class AcceptMaintenanceAppointmentLoadingState
    extends WorkshopOwnerRequestsState {}

class AcceptMaintenanceAppointmentSuccessState
    extends WorkshopOwnerRequestsState {
  final Response response;
  AcceptMaintenanceAppointmentSuccessState(this.response);
}

class AcceptMaintenanceAppointmentErrorState
    extends WorkshopOwnerRequestsState {
  final error;
  AcceptMaintenanceAppointmentErrorState(this.error);
}

class SetVisitAppointmentLoadingState extends WorkshopOwnerRequestsState {}

class SetVisitAppointmentSuccessState extends WorkshopOwnerRequestsState {
  final Response response;
  SetVisitAppointmentSuccessState(this.response);
}

class SetVisitAppointmentErrorState extends WorkshopOwnerRequestsState {
  final error;
  SetVisitAppointmentErrorState(this.error);
}
