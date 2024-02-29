import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'workshop_owner_inprogress_cars_state.dart';

class WorkshopOwnerInProgressCarCubit
    extends Cubit<WorkshopOwnerInProgressCarState> {
  WorkshopOwnerInProgressCarCubit()
      : super(WorkshopOwnerInProgressCarInitialState());

  static WorkshopOwnerInProgressCarCubit get(context) =>
      BlocProvider.of(context);
  List currentCars = [];

  void getWorkshopInfo() async {
    // final response = await DioHelper.get(url);
  }

  Future<void> getCurrentCars() async {
    emit(GetWorkshopCurrentCarsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    // int userId = token.print(token);
    try {
      final response = await DioHelper.get(getCurrentCarsURL,
          token: 'JWT $token', query: {'transactionStatus': 5});
      print(response);
      // currentCars = response.data;

      if (response.statusCode == 200) {
        emit(GetWorkshopCurrentCarsSuccessState());
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetWorkshopCurrentCarsErrorState());
      } else if (error.type == DioExceptionType.connectionError) {
        emit(GetWorkshopCurrentCarsErrorState());
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetWorkshopCurrentCarsErrorState());
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(GetWorkshopCurrentCarsErrorState());
      } else if (error.type == DioExceptionType.badResponse) {
        emit(GetWorkshopCurrentCarsErrorState());
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(GetWorkshopCurrentCarsErrorState());
        } else if (error.response!.statusCode == 401) {
          emit(GetWorkshopCurrentCarsErrorState());
        } else if (error.response!.statusCode == 403) {
          emit(GetWorkshopCurrentCarsErrorState());
        } else if (error.response!.statusCode == 404) {
          emit(GetWorkshopCurrentCarsErrorState());
        }
      } else {
        emit(GetWorkshopCurrentCarsErrorState());
      }
    } catch (error) {
      emit(GetWorkshopCurrentCarsErrorState());
    }
  }
}
