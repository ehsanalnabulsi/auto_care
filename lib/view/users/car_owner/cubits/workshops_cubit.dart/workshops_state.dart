part of 'workshops_cubit.dart';

class WorkshopsState {}

class WorkshopsInitialState extends WorkshopsState {}

class UpdateIsSearchingState extends WorkshopsState {}

class GetWorkshopsLoadingState extends WorkshopsState {}

class GetWorkshopsSuccessState extends WorkshopsState {
  final Response response;
  GetWorkshopsSuccessState(this.response);
}

class GetWorkshopsErrorState extends WorkshopsState {
  final String? error;
  GetWorkshopsErrorState(this.error);
}

class GetSpecialistsLoadingState extends WorkshopsState {}

class GetSpecialistsSuccessState extends WorkshopsState {
  final Response response;
  GetSpecialistsSuccessState(this.response);
}

class GetSpecialistsErrorState extends WorkshopsState {
  final String? error;
  GetSpecialistsErrorState(this.error);
}

class GetOriginsLoadingState extends WorkshopsState {}

class GetOriginsSuccessState extends WorkshopsState {
  final Response response;
  GetOriginsSuccessState(this.response);
}

class GetOriginsErrorState extends WorkshopsState {
  final String? error;
  GetOriginsErrorState(this.error);
}

class UpdateSelectedOrigin extends WorkshopsState {}

class UpdateSelectedSpecialist extends WorkshopsState {}

class GetUserCarsLoadingState extends WorkshopsState {}

class GetUserCarsSuccessState extends WorkshopsState {}

class GetUserCarsErrorState extends WorkshopsState {}
