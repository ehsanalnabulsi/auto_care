import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/functions/get_car_id_by_name.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
part 'create_maintenance_request_state.dart';

class CreateMaintenanceRequestCubit
    extends Cubit<CreateMaintenanceRequestState> {
  CreateMaintenanceRequestCubit() : super(CreateMaintenanceRequestInitial());
  static CreateMaintenanceRequestCubit get(context) => BlocProvider.of(context);
  List userCars = [];
  String? selectedCarName;
  String? selectedWorkshopName;
  int? selectedCar;
  int? selectedWorkshop;

  List<String> userCarsNames = [];
  List<String> userCarsIds = [];
  List<String> userCarsPlatesNumber = [];
  List<String> userCarsImages = [];
  List workshops = [];
  List<String> workshopsNames = [];

  void getUserCars() async {
    String? token = CacheHelper.getString(key: 'token');
    print(token);
    try {
      emit(GetUserCarsLoadingState());
      final response = await DioHelper.get(userCarsURL, token: 'JWT $token');
      userCars = response.data;
      print(userCars);
      userCarsNames =
          userCars.map((entry) => entry["modelName"].toString()).toList();
      userCarsIds = userCars.map((entry) => entry["carId"].toString()).toList();
      userCarsImages =
          userCars.map((entry) => entry["avatar"].toString()).toList();
      userCarsPlatesNumber =
          userCars.map((entry) => entry["plateNumber"].toString()).toList();
      emit(GetUserCarsSuccessState());
    } catch (error) {
      emit(GetUserCarsErrorState());
    }
  }

  void getWorkshopsByCarModel(carId) async {
    emit(GetWorkshopsLoadingState());
    Map<String, dynamic>? userCar =
        userCars.firstWhere((car) => car["carId"] == carId, orElse: () => null);
    print(userCar);
    selectedCar = int.parse(carId);
    print('=------------------=====---------==========------=');
    print(carId);
    print('=------------------=====---------==========------=');
    print(selectedCar);
    print('=------------------=====---------==========------=');

    // selectedCar = carId as int;
    if (userCar != null) {
      final response = await DioHelper.get(workshopsURL, query: {
        'brands': userCar["carBrand"],
      }).then((value) {
        workshops = value.data;
        workshopsNames = [];
        for (var workshop in workshops) {
          if (workshop.containsKey("workshopName")) {
            workshopsNames.add(workshop["workshopName"]);
          }
        }
      });
      emit(GetWorkshopsSuccessState(response));
    }
  }

  void updateSelectedWorkshop(workshopName) {
    selectedWorkshop = getWorkshopIdByWorkshopName(workshops, workshopName);
    print(selectedWorkshop);
    emit(UpdateSelectedWorkshopState());
  }

  Future<void> createMaintenanceRequest(
      {required int carId,
      required int workshopId,
      required String description}) async {
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({
      'carsId': carId,
      'workshopId': workshopId,
      'requestType': 1,
      'description': description,
    });
    try {
      final response = await DioHelper.postForm(createMaintenanceRequestURL,
          token: 'JWT $token', data: formData);
      print(response);

      if (response.statusCode == 200) {
        emit(CreateMaintenanceRequestSuccessState(response));
      }
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(CreateMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.connectionError) {
        emit(CreateMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(CreateMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.sendTimeout) {
        emit(CreateMaintenanceRequestErrorState(error));
      } else if (error.type == DioExceptionType.badResponse) {
        emit(CreateMaintenanceRequestErrorState(error));
      } else if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(CreateMaintenanceRequestErrorState(error));
        } else if (error.response!.statusCode == 401) {
          emit(CreateMaintenanceRequestErrorState(error.response!.data['']));
        } else if (error.response!.statusCode == 403) {
          emit(CreateMaintenanceRequestErrorState(error.response!.data['']));
        } else if (error.response!.statusCode == 404) {
          emit(CreateMaintenanceRequestErrorState(error.response!.data['']));
        }
      } else {
        emit(CreateMaintenanceRequestErrorState(error));
      }
    } catch (error) {
      emit(CreateMaintenanceRequestErrorState(error as DioException?));
    }
  }
}
