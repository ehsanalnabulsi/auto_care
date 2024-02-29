import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
part 'car_owner_requests_state.dart';

class CarOwnerRequestsCubit extends Cubit<CarOwnerRequestsState> {
  CarOwnerRequestsCubit() : super(RequestsPageInitial());
  static CarOwnerRequestsCubit get(context) => BlocProvider.of(context);
  List userRequests = [];
  List userHistoryRequests = [];
  List userTowCarRequests = [];

  Future<void> getUserRequests() async {
    emit(GetUserRequestsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    // int userId = token.print(token);
    try {
      final response = await DioHelper.get(getCarOwnersRequestsURL,
          token: 'JWT $token',
          query: {'requestType': 1, 'transactionsStatus': 6});
      // print(response.data[3]);
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

  Future<void> getUserRequestsHistory() async {
    emit(GetUserRequestsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    // int userId = token.print(token);
    try {
      final response = await DioHelper.get(getCarOwnerRequestsURL,
          token: 'JWT $token',
          query: {'requestType': 1, 'transactionStatus': 6});
      // print(response.data[3]);
      userHistoryRequests = response.data;
      print(userRequests[2]);

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

  Future<void> getUserRequestsTowCar() async {
    emit(GetUserRequestsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    // int userId = token.print(token);
    try {
      final response = await DioHelper.get(getCarOwnerRequestsURL,
          token: 'JWT $token', query: {'requestType': 2});
      // print(response.data[3]);
      userHistoryRequests = response.data;
      print(userRequests[2]);

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

  Future<void> acceptMaintenanceAppointment(int requestId) async {
    emit(AcceptMaintenanceAppointmentLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({'status': 1});
    try {
      final response = await DioHelper.put(
        url: '$acceptMaintenanceAppointmentURL$requestId/',
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
        url: '$acceptPriceMaintenanceAppointmentURL$requestId/',
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
}
