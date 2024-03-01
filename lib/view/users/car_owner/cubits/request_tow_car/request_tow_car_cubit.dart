import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/functions/get_car_id_by_name.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'request_tow_car_state.dart';

class RequestTowCarCubit extends Cubit<RequestTowCarState> {
  RequestTowCarCubit() : super(RequestTowCarInitial());
  static RequestTowCarCubit get(context) => BlocProvider.of(context);
  late LocationData locationData;
  List availableTowCars = [];
  LatLng currentLocation = const LatLng(0, 0);
  late List userCars;
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
  List<Marker> markers = [];
  LatLng destinationLocation = const LatLng(0, 0);
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

  Future<void>? createTowCarRequest({
    required int carId,
    required LatLng currentLocation,
    required LatLng destinationLocation,
  }) async {
    emit(CreateTowCarRequestLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    print('=============');
    print(token);
    print('=============');
    print(carId);
    print(currentLocation);
    print(destinationLocation);
    print(destinationLocation.longitude);

    FormData formData = FormData.fromMap({
      'currentLocation':
          '${currentLocation.latitude},${currentLocation.longitude}',
      'destination':
          '${destinationLocation.latitude},${destinationLocation.longitude}',
      'requestType': 2,
      'carsId': carId,
    });
    try {
      final response = DioHelper.postForm(createTowRequestURL,
          data: formData, token: 'JWT $token');
      print(response);
      emit(CreateTowCarRequestSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(CreateTowCarRequestErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(CreateTowCarRequestErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(CreateTowCarRequestErrorState(error.message));
            break;
          case 401:
            emit(CreateTowCarRequestErrorState(error.message));
            break;
          case 404:
            emit(CreateTowCarRequestErrorState(error.message));
            break;
          default:
            emit(CreateTowCarRequestErrorState(error.message));
        }
      } else {
        emit(CreateTowCarRequestErrorState(error.message));
      }
    }
  }

  Future<void>? getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    locationData = await LocationService.getCurrentLocation();
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    markers.add(Marker(
      point: currentLocation,
      child: Transform.translate(
        offset: const Offset(-35, -50),
        child: const Icon(
          Icons.location_on,
          size: 75,
          color: AppColors.secondaryColor,
        ),
      ),
    ));
    emit(GetCurrentLocationSuccessState(locationData));
  }

  Future<void>? getWorkshops() async {
    emit(GetCurrentLocationLoadingState());
    locationData = await LocationService.getCurrentLocation();
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    markers.add(Marker(
      point: currentLocation,
      child: Transform.translate(
        offset: const Offset(-35, -50),
        child: const Icon(
          Icons.location_on,
          size: 75,
          color: AppColors.secondaryColor,
        ),
      ),
    ));
    emit(GetCurrentLocationSuccessState(locationData));
  }

  Future<void>? getAvailableTowCars() async {
    emit(GetAvailableTowCarsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    FormData formData = FormData.fromMap({
      'currentLocation':
          '${currentLocation.latitude},${currentLocation.longitude}'
    });
    try {
      final response = await DioHelper.get(
        getAvailableTowCarURL,
        token: 'JWT $token',
        formData: formData,
      );
      print(response);
      availableTowCars = response.data;

      for (Map<String, dynamic> towCar in availableTowCars) {
        List<String> splitValues = towCar['location'].split(',');
        double latitude = double.parse(splitValues[0]);
        double longitude = double.parse(splitValues[1]);
        markers.add(Marker(
          point: LatLng(latitude, longitude),
          child: Transform.translate(
            offset: const Offset(-35, -50),
            child: const Icon(
              Icons.fire_truck_sharp,
              size: 35,
              color: AppColors.greyColor,
            ),
          ),
        ));
      }
      print(markers);
      emit(GetAvailableTowCarsSuccessState(locationData));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetAvailableTowCarsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetAvailableTowCarsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetAvailableTowCarsErrorState(error.message));
            break;
          case 401:
            emit(GetAvailableTowCarsErrorState(error.message));
            break;
          case 404:
            emit(GetAvailableTowCarsErrorState(error.message));
            break;
          default:
            emit(GetAvailableTowCarsErrorState(error.message));
        }
      } else {
        emit(GetAvailableTowCarsErrorState(error.message));
      }
    } catch (error) {
      emit(GetAvailableTowCarsErrorState(error.toString()));
    }
  }

  void getDestinationPoint(TapPosition tapPosition, LatLng newLocation) async {
    try {
      emit(GetDestinationPointLoadingState());
      print(destinationLocation);
      destinationLocation = newLocation;
      if (markers.length == 2) {
        markers.removeLast();
        markers.add(Marker(
          point: destinationLocation,
          child: Transform.translate(
            offset: const Offset(-25, -50),
            child: const Icon(
              Icons.location_on,
              size: 75,
              color: AppColors.secondaryColor,
            ),
          ),
        ));
      } else {
        markers.add(Marker(
          point: destinationLocation,
          child: Transform.translate(
            offset: const Offset(-25, -50),
            child: const Icon(
              Icons.location_on,
              size: 75,
              color: AppColors.secondaryColor,
            ),
          ),
        ));
      }

      emit(GetDestinationPointSuccessState(locationData));
    } catch (e) {
      emit(GetCurrentLocationErrorState());
    }
  }
}
