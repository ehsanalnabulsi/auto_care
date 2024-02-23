// import 'package:auto_care/view/car_owner/screens/notifications.dart';
// import 'package:auto_care/view/car_owner/screens/search.dart';
// import 'package:auto_care/view/car_owner/screens/settings.dart';

import 'package:auto_care/core/constant/imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'main_page_state.dart';

class CarOwnerMainPageCubit extends Cubit<CarOwnerMainPageState> {
  CarOwnerMainPageCubit() : super(CarOwnerMainPageInitial());
  static CarOwnerMainPageCubit get(context) => BlocProvider.of(context);
  int? page = Get.arguments;

  int currentIndex = Get.arguments ?? 0;

  // Car? selectedCar;
  // bool isSelected = false;

  // void changeSelectedCar(car) {
  //   selectedCar = car;
  //   isSelected = true;
  //   emit(ChangeSelectedCar());
  // }

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeNavigationBarIndex());
  }
}
