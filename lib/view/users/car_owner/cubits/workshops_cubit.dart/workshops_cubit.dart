import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';

part 'workshops_state.dart';

class WorkshopsCubit extends Cubit<WorkshopsState> {
  WorkshopsCubit() : super(WorkshopsInitialState());
  static WorkshopsCubit get(context) => BlocProvider.of(context);
  List workshops = [];
  List specialists = [];
  List origins = [];
  List<String> chipSpecialists = ['All'];
  List<String> chipOrigins = ['All'];
  List userCars = [];
  String? selectedCar;
  int selectedOriginIndex = 0;
  int selectedSpecialistIndex = 0;

  void getUserCars() async {
    String? token = CacheHelper.getString(key: 'token');
    try {
      emit(GetUserCarsLoadingState());
      final response = await DioHelper.get(userCarsURL, token: 'JWT $token');
      userCars = response.data;

      emit(GetUserCarsSuccessState());
    } catch (error) {
      emit(GetUserCarsErrorState());
    }
  }

  void getSpecialists() async {
    try {
      emit(GetSpecialistsLoadingState());
      final response = await DioHelper.get(specialistsURL);
      specialists = response.data;
      chipSpecialists = [
        'All',
        ...specialists.map((item) => item["name"] as String).toList()
      ];
      emit(GetSpecialistsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetSpecialistsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetSpecialistsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetSpecialistsErrorState(error.message));
            break;
          case 401:
            emit(GetSpecialistsErrorState(error.message));
            break;
          case 404:
            emit(GetSpecialistsErrorState(error.message));
            break;
          default:
            emit(GetSpecialistsErrorState(error.message));
        }
      } else {
        emit(GetSpecialistsErrorState(error.message));
      }
    } catch (error) {
      emit(GetSpecialistsErrorState(error.toString()));
    }
  }

  void getOrigins() async {
    try {
      emit(GetOriginsLoadingState());
      final response = await DioHelper.get(originsURL);
      origins = response.data;
      chipOrigins = [
        'All',
        ...origins.map((item) => item["name"] as String).toList()
      ];
      emit(GetOriginsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetOriginsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetOriginsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetOriginsErrorState(error.message));
            break;
          case 401:
            emit(GetOriginsErrorState(error.message));
            break;
          case 404:
            emit(GetOriginsErrorState(error.message));
            break;
          default:
            emit(GetOriginsErrorState(error.message));
        }
      } else {
        emit(GetOriginsErrorState(error.message));
      }
    } catch (error) {
      emit(GetOriginsErrorState(error.toString()));
    }
  }

  void getWorkshopsByCarModel(modelName) async {
    try {
      emit(GetWorkshopsLoadingState());
      Map<String, dynamic>? userCar = userCars.firstWhere(
          (car) => car["modelName"] == modelName,
          orElse: () => null);
      int carBrand = -1;
      if (userCar != null) {
        carBrand = userCar["carBrand"];
      } else {}
      final response = await DioHelper.get(workshopsURL, query: {
        'brands': carBrand,
      });
      workshops = response.data;

      emit(GetWorkshopsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetWorkshopsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetWorkshopsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetWorkshopsErrorState(error.message));
            break;
          case 401:
            emit(GetWorkshopsErrorState(error.message));
            break;
          case 404:
            emit(GetWorkshopsErrorState(error.message));
            break;
          default:
            emit(GetWorkshopsErrorState(error.message));
        }
      } else {
        emit(GetWorkshopsErrorState(error.message));
      }
    } catch (error) {
      emit(GetWorkshopsErrorState(error.toString()));
    }
  }

  void getWorkshopsById(specialist, origin) async {
    try {
      emit(GetWorkshopsLoadingState());
      final response = await DioHelper.get(workshopsURL,
          query: {'specialist': specialist, 'origin': origin});
      workshops = response.data;

      emit(GetWorkshopsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetWorkshopsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetWorkshopsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetWorkshopsErrorState(error.message));
            break;
          case 401:
            emit(GetWorkshopsErrorState(error.message));
            break;
          case 404:
            emit(GetWorkshopsErrorState(error.message));
            break;
          default:
            emit(GetWorkshopsErrorState(error.message));
        }
      } else {
        emit(GetWorkshopsErrorState(error.message));
      }
    } catch (error) {
      emit(GetWorkshopsErrorState(error.toString()));
    }
  }

  void updateSelectedSpecialist(value) {
    selectedSpecialistIndex = value;
    if (selectedSpecialistIndex != 0) {
      if (selectedOriginIndex != 0) {
        getWorkshopsById(selectedSpecialistIndex, selectedOriginIndex);
      } else {
        getWorkshopsById(selectedSpecialistIndex, null);
      }
    } else {
      getWorkshops();
    }
    emit(UpdateSelectedSpecialist());
  }

  void updateSelectedOrigin(value) {
    selectedOriginIndex = value;
    if (selectedOriginIndex != 0) {
      if (selectedSpecialistIndex != 0) {
        getWorkshopsById(selectedSpecialistIndex, selectedOriginIndex);
      } else {
        getWorkshopsById(null, selectedOriginIndex);
      }
    } else {
      getWorkshops();
    }
    emit(UpdateSelectedOrigin());
  }

  void getWorkshops() async {
    try {
      emit(GetWorkshopsLoadingState());
      final response = await DioHelper.get(workshopsURL);
      workshops = response.data;

      emit(GetWorkshopsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetWorkshopsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetWorkshopsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetWorkshopsErrorState(error.message));
            break;
          case 401:
            emit(GetWorkshopsErrorState(error.message));
            break;
          case 404:
            emit(GetWorkshopsErrorState(error.message));
            break;
          default:
            emit(GetWorkshopsErrorState(error.message));
        }
      } else {
        emit(GetWorkshopsErrorState(error.message));
      }
    } catch (error) {
      emit(GetWorkshopsErrorState(error.toString()));
    }
  }
}
