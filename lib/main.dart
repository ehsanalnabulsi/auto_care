// ignore_for_file: avoid_print

import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app/app.dart';

// cd C:\Users\Ehsan\Documents\BACKEND\work_shop_venv\Scripts
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  await Firebase.initializeApp();
  DioHelper.initialize();
  bool isDark;
  bool isLoggedIn;
  bool isOnboardingSkipped;

  String userType;

  isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
  CacheHelper.getString(key: 'token') == null
      ? isLoggedIn = false
      : isLoggedIn = true;
  isOnboardingSkipped =
      CacheHelper.getBoolean(key: 'onBoardingSkipped') ?? false;
  userType = CacheHelper.getString(key: 'userType') ?? '';

  runApp(MyApp(
      isDark: isDark,
      isLoggedIn: isLoggedIn,
      userType: userType,
      isOnboardingSkipped: isOnboardingSkipped));
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
