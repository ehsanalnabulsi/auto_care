import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workshop_owner_requests_state.dart';

class WorkshopOwnerRequestsCubit extends Cubit<WorkshopOwnerRequestsState> {
  WorkshopOwnerRequestsCubit() : super(WorkshopOwnerRequestsInitial());
  static WorkshopOwnerRequestsCubit get(context) => BlocProvider.of(context);
  List userRequests = [];

  Future<void> getUserRequests() async {
    emit(GetUserRequestsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    // int userId = token.print(token);
    try {
      final response = await DioHelper.get(getWorkshopOwnerRequestsURL,
          token: 'JWT $token', query: {'requestType': 1});
      print(response);
      userRequests = response.data;

      emit(GetUserRequestsSuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.connectionError) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.badResponse) {
        emit(GetUserRequestsErrorState());
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(GetUserRequestsErrorState());
        } else if (error.response!.statusCode == 401) {
          emit(GetUserRequestsErrorState());
        } else if (error.response!.statusCode == 403) {
          emit(GetUserRequestsErrorState());
        } else if (error.response!.statusCode == 404) {
          emit(GetUserRequestsErrorState());
        }
      } else {
        emit(GetUserRequestsErrorState());
      }
    } catch (error) {
      emit(GetUserRequestsErrorState());
    }
  }

  Future<void> cancelMaintenanceRequest(int requestId) async {
    emit(CancelMaintenanceRequestLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({'status': 3});
    try {
      final response = await DioHelper.put(
        url: '$cancelRequestURL$requestId/',
        token: 'JWT $token',
        formData: formData,
      );
      print(response);
      if (response.statusCode == 200) {
        emit(CancelMaintenanceRequestSuccessState(response));
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(CancelMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.connectionError) {
        emit(CancelMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(CancelMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(CancelMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.badResponse) {
        emit(CancelMaintenanceRequestErrorState(error));
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(CancelMaintenanceRequestErrorState(error));
        } else if (error.response!.statusCode == 401) {
          emit(CancelMaintenanceRequestErrorState(error));
        } else if (error.response!.statusCode == 403) {
          emit(CancelMaintenanceRequestErrorState(error));
        } else if (error.response!.statusCode == 404) {
          emit(CancelMaintenanceRequestErrorState(error));
        }
      } else {
        emit(CancelMaintenanceRequestErrorState(error));
      }
    } catch (error) {
      emit(CancelMaintenanceRequestErrorState(error));
    }
  }

  Future<void> setVisitAppointment(int requestId, DateTime date) async {
    emit(SetVisitAppointmentLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({
      'date': date,
    });
    try {
      final response = await DioHelper.patch(
        url: '$setVisitAppointmentURL$requestId/',
        token: 'JWT $token',
        formData: formData,
      );
      print(response);
      if (response.statusCode == 200) {
        emit(SetVisitAppointmentSuccessState(response));
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(SetVisitAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.connectionError) {
        emit(SetVisitAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(SetVisitAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(SetVisitAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.badResponse) {
        emit(SetVisitAppointmentErrorState(error));
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(SetVisitAppointmentErrorState(error));
        } else if (error.response!.statusCode == 401) {
          emit(SetVisitAppointmentErrorState(error));
        } else if (error.response!.statusCode == 403) {
          emit(SetVisitAppointmentErrorState(error));
        } else if (error.response!.statusCode == 404) {
          emit(SetVisitAppointmentErrorState(error));
        }
      } else {
        emit(SetVisitAppointmentErrorState(error));
      }
    } catch (error) {
      emit(SetVisitAppointmentErrorState(error));
    }
  }

  Future<void> acceptMaintenanceAppointment(int requestId) async {
    emit(AcceptMaintenanceAppointmentLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({'status': 1});
    try {
      final response = await DioHelper.put(
        url: '$cancelRequestURL$requestId/',
        token: 'JWT $token',
        formData: formData,
      );
      print(response);
      if (response.statusCode == 200) {
        emit(AcceptMaintenanceAppointmentSuccessState(response));
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.connectionError) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.badResponse) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        } else if (error.response!.statusCode == 401) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        } else if (error.response!.statusCode == 403) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        } else if (error.response!.statusCode == 404) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        }
      } else {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      }
    } catch (error) {
      emit(AcceptMaintenanceAppointmentErrorState(error));
    }
  }

  Future<void> acceptMaintenanceEvaluate(int requestId) async {
    emit(AcceptMaintenanceAppointmentLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({'status': 1});
    try {
      final response = await DioHelper.put(
        url: '$cancelRequestURL$requestId/',
        token: 'JWT $token',
        formData: formData,
      );
      print(response);
      if (response.statusCode == 200) {
        emit(AcceptMaintenanceAppointmentSuccessState(response));
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.connectionError) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.type == DioExceptionType.badResponse) {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        } else if (error.response!.statusCode == 401) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        } else if (error.response!.statusCode == 403) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        } else if (error.response!.statusCode == 404) {
          emit(AcceptMaintenanceAppointmentErrorState(error));
        }
      } else {
        emit(AcceptMaintenanceAppointmentErrorState(error));
      }
    } catch (error) {
      emit(AcceptMaintenanceAppointmentErrorState(error));
    }
  }

  Future<void> declineRequest() async {
    emit(GetUserRequestsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    // int userId = token.print(token);
    try {
      final response = await DioHelper.get(getWorkshopOwnerRequestsURL,
          token: 'JWT $token', query: {'requestType': 1});
      print(response);
      userRequests = response.data;

      emit(GetUserRequestsSuccessState());
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.connectionError) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(GetUserRequestsErrorState());
      } else if (error.type == DioExceptionType.badResponse) {
        emit(GetUserRequestsErrorState());
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(GetUserRequestsErrorState());
        } else if (error.response!.statusCode == 401) {
          emit(GetUserRequestsErrorState());
        } else if (error.response!.statusCode == 403) {
          emit(GetUserRequestsErrorState());
        } else if (error.response!.statusCode == 404) {
          emit(GetUserRequestsErrorState());
        }
      } else {
        emit(GetUserRequestsErrorState());
      }
    } catch (error) {
      emit(GetUserRequestsErrorState());
    }
  }
}
