
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/screens/requests/request_tow_car_pages/request_tow_car_page.dart';
import 'package:get/get.dart';

class SharedRoutes {
  //      Shared Routes Names
  //        Authentication
  //           Login Routes
  static const String login = '/login';
  static const String forgetPassword = '/login';
  //           Register Routes
  static const String registerMainPage = '/registerMainPage';
  //              Register Car Owner Routes
  static const String registerCarOwnerPage = '/registerCarOwnerPage';
  //              Register Tow Owner Routes
  static const String registerTowCarOwnerPage = '/registerTowCarOwnerPage';
  //              Register Workshop Owner Routes
  static const String registerWorkshopOwnerPage = '/registerWorkshopOwnerPage';
  static const String addWorkshopLocation = '/addWorkshopLocation';
  //              Register PartsSupplier Routes
  static const String registerPartsSupplier = '/registerPartsSupplier';
  static const String addStoreLocation = '/addStoreLocation';
}

class WorkshopOwnerRoutes {
  static const String workshopOwnerMainPage = '/workshopOwnerMainPage';
}

class PartsSupplierRoutes {
  static const String partsSupplierHomePage = '/partsSuppliersHomePage';
  static const String addNewProduct = '/addNewProduct';
}

class TowCarRoutes {
  static const String towCarOwnerHomePage = '/towCarOwnerHomePage';
  static const String towCarProfile = '/towCarProfile';
  static const String towCarOrders = '/towCarOrders';
}

class CarOwnerRoutes {
  static const String addNewCar = '/addNewCar';
  static const String carDetailsPage = '/carDetails';
  static const String carOwnerMainPage = '/carOwnerMainPage';
  static const String workshops = '/workshops';
  static const String carWorkshops = '/carWorkshops';
  static const String workshopDetails = '/workshopDetails';
  static const String storeDetails = '/storeDetails';
  static const String editProfile = '/editProfile';
  static const String partsSuppliers = '/partsSuppliers';
  static const String productDetails = '/productDetails';
  static const String createMaintenanceRequest = '/createMaintenanceRequest';
  static const String towCarRequest = '/towCarRequest';
}

List<GetPage<dynamic>> routes = [
  //                    Shared Routes
  //                     Authentication
  //                     Login Routes
  GetPage(name: SharedRoutes.login, page: () => const LoginPage()),
  GetPage(
      name: SharedRoutes.addWorkshopLocation,
      page: () => const AddWorkshopLocationPage()),
  GetPage(
      name: SharedRoutes.addStoreLocation,
      page: () => const AddStoreLocationPage()),
//                      Register
  GetPage(
      name: SharedRoutes.registerMainPage,
      page: () => const RegisterMainPage()),

  GetPage(
      name: SharedRoutes.registerMainPage,
      page: () => const RegisterMainPage()),
  GetPage(
      name: SharedRoutes.registerCarOwnerPage,
      page: () => const RegisterCarOwnerPage()),
  GetPage(
      name: SharedRoutes.registerTowCarOwnerPage,
      page: () => const RegisterTowCarOwnerPage()),
  GetPage(
      name: SharedRoutes.registerWorkshopOwnerPage,
      page: () => const RegisterWorkshopOwnerPage()),
  GetPage(
      name: SharedRoutes.registerPartsSupplier,
      page: () => const RegisterPartsSupplierPage()),

  //           Car Owner Pages
  GetPage(
      name: CarOwnerRoutes.carOwnerMainPage,
      page: () => const CarOwnerMainPage()),
  GetPage(name: CarOwnerRoutes.addNewCar, page: () => const AddNewCar()),
  GetPage(
      name: CarOwnerRoutes.carDetailsPage, page: () => const CarDetailsPage()),
  GetPage(name: CarOwnerRoutes.workshops, page: () => const WorkshopsPage()),
  GetPage(name: CarOwnerRoutes.editProfile, page: () => const EditProfile()),
  GetPage(
      name: CarOwnerRoutes.partsSuppliers, page: () => const PartsSuppliers()),
  GetPage(
      name: CarOwnerRoutes.productDetails,
      page: () => ProductDetails(product: Get.arguments.product)),
  GetPage(
      name: CarOwnerRoutes.workshopDetails,
      page: () => const WorkshopDetailsPage()),
  GetPage(
      name: CarOwnerRoutes.storeDetails,
      page: () => const PartsSupplierDetailsPage()),
  GetPage(
      name: CarOwnerRoutes.createMaintenanceRequest,
      page: () => const CreateMaintenanceRequest()),
  GetPage(
      name: CarOwnerRoutes.towCarRequest,
      page: () => const RequestTowCarPage()),

  //           Workshop Owner Pages
  GetPage(
      name: WorkshopOwnerRoutes.workshopOwnerMainPage,
      page: () => const WorkshopOwnerMainPage()),

  //  Tow Car Owner Pages
  GetPage(
      name: TowCarRoutes.towCarProfile,
      page: () => const TowCarOwnerProfilePage()),
  GetPage(
      name: TowCarRoutes.towCarOrders, page: () => const TowCarOwnerOrders()),
  GetPage(
      name: TowCarRoutes.towCarOwnerHomePage,
      page: () => const TowCarOwnerHomePage()),
  //  PartsSupplier Pages
  GetPage(
      name: PartsSupplierRoutes.partsSupplierHomePage,
      page: () => const PartsSupplierHomePage()),
  GetPage(
      name: PartsSupplierRoutes.addNewProduct,
      page: () => const AddNewProduct())
];
