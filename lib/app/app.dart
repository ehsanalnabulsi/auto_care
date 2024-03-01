import 'package:auto_care/app/cubit/cubit.dart';
import 'package:auto_care/app/cubit/states.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/constant/themes.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:auto_care/view/common/cubits/register/parts_supplier/register_parts_supplier_cubit.dart';
import 'package:auto_care/view/common/cubits/register/workshop_owner/register_workshop_owner_cubit.dart';
import 'package:auto_care/view/users/car_owner/cubits/main_page_cubit/main_page_cubit.dart';
import 'package:auto_care/view/users/car_owner/cubits/request_tow_car/request_tow_car_cubit.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.isDark,
      required this.isLoggedIn,
      required this.isOnboardingSkipped,
      required this.userType});
  final bool isDark;
  final bool isLoggedIn;
  final bool isOnboardingSkipped;
  final String userType;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => CarOwnerMainPageCubit()),
        BlocProvider(
            create: (context) => RegisterPartsSupplierCubit()..getOrigins()),
        BlocProvider(
            create: (context) => RegisterWorkshopOwnerCubit()
              ..getOrigins()
              ..getSpecialists()),
        BlocProvider(create: (context) => RequestTowCarCubit()..getUserCars())
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LocationService.checkPermission();
          Widget route = const LoginPage();

          // if (!isLoggedIn) {
          //   route = LoginPage();
          // } else if (userType == 'carOwner') {
          //   route = CarOwnerMainPage();
          // } else if (userType == 'workshopOwner') {
          //   route = WorkshopOwnerMainPage();
          // } else if (userType == 'towCarOwner') {
          //   route = TowCarOwnerHomePage();
          // } else if (userType == 'partsSupplier') {
          //   route = PartsSupplierHomePage();
          // }

          // var cubit = AppCubit.get(context);
          return GetMaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              // themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              getPages: routes,
              home: route);
        },
      ),
    );
  }
}
