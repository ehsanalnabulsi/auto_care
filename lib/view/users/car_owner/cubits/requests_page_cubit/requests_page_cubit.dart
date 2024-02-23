import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';

part 'requests_page_state.dart';

class RequestsPageCubit extends Cubit<RequestsPageState> {
  RequestsPageCubit() : super(RequestsPageInitial());
  static RequestsPageCubit get(context) => BlocProvider.of(context);
  List userRequests = [];

  Future<void> getUserRequests() async {
    emit(GetUserRequestsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    print(token);
    try {
      final response =
          await DioHelper.get(createMaintenanceRequestURL, token: 'JWT $token');
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
