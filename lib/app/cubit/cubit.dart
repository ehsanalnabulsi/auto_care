import 'package:auto_care/app/cubit/states.dart';
import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    // CatchHelper.setData(key: 'isDark', value: isDark)
    //     .then((value) => emit(AppChangeModeState()));
  }
}
