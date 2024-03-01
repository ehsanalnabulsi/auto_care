import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_state.dart';

class PartsSuppliersCubit extends Cubit<PartsSuppliersState> {
  PartsSuppliersCubit() : super(PartsSuppliersInitialState());
  static PartsSuppliersCubit get(context) => BlocProvider.of(context);
  List partsSuppliers = [];
  List partsSupplierProducts = [];
  List categories = [];
  List<String> chipCategories = [];
  int? selectedCategoryIndex;
  void updateSelectedSpecialist(value) {
    selectedCategoryIndex = value;
    if (selectedCategoryIndex != 0) {
    } else {}
    emit(UpdateSelectedCategory());
  }

  void getOrigins() {
    DioHelper.get(originsURL).then((value) => null);
  }

  void getSpecialists() async {
    try {
      emit(GetSpecialistsLoadingState());
      final response = await DioHelper.get(specialistsURL);
      categories = response.data;
      chipCategories = [
        'All',
        ...categories.map((item) => item["name"] as String).toList()
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

  Future<void> getPartsSupplierProducts(int id) async {
    String? token = CacheHelper.getString(key: 'token');
    try {
      emit(GetPartsSupplierProductsLoadingState());

      final response = await DioHelper.get(partsSupplierProductURL,
          token: 'JWT $token', query: {'partSupplierId': id});
      print('============================');
      print(response);
      print('============================');
      partsSupplierProducts = response.data;
      print('========+++++++++++++======================');

      print(partsSupplierProducts);
      print('==========+++++++++==================');

      emit(GetPartsSupplierProductsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetPartsSupplierProductsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetPartsSupplierProductsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetPartsSupplierProductsErrorState(error.message));
            break;
          case 401:
            emit(GetPartsSupplierProductsErrorState(error.message));
            break;
          case 404:
            emit(GetPartsSupplierProductsErrorState(error.message));
            break;
          default:
            emit(GetPartsSupplierProductsErrorState(error.message));
        }
      } else {
        emit(GetPartsSupplierProductsErrorState(error.message));
      }
    } catch (error) {
      emit(GetPartsSupplierProductsErrorState(error.toString()));
    }
  }

  void getPartsSuppliers() async {
    try {
      emit(GetPartsSuppliersLoadingState());
      final response = await DioHelper.get(carOwnerPartsSupplier);
      partsSuppliers = response.data;

      emit(GetPartsSuppliersSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetPartsSuppliersErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetPartsSuppliersErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetPartsSuppliersErrorState(error.message));
            break;
          case 401:
            emit(GetPartsSuppliersErrorState(error.message));
            break;
          case 404:
            emit(GetPartsSuppliersErrorState(error.message));
            break;
          default:
            emit(GetPartsSuppliersErrorState(error.message));
        }
      } else {
        emit(GetPartsSuppliersErrorState(error.message));
      }
    } catch (error) {
      emit(GetPartsSuppliersErrorState(error.toString()));
    }
  }

  void getProducts() async {
    try {
      emit(GetPartsSupplierProductsLoadingState());
      final response = await DioHelper.get(getProductsURL);
      partsSupplierProducts = response.data;

      emit(GetPartsSupplierProductsSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(GetPartsSupplierProductsErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(GetPartsSupplierProductsErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(GetPartsSupplierProductsErrorState(error.message));
            break;
          case 401:
            emit(GetPartsSupplierProductsErrorState(error.message));
            break;
          case 404:
            emit(GetPartsSupplierProductsErrorState(error.message));
            break;
          default:
            emit(GetPartsSupplierProductsErrorState(error.message));
        }
      } else {
        emit(GetPartsSupplierProductsErrorState(error.message));
      }
    } catch (error) {
      emit(GetPartsSupplierProductsErrorState(error.toString()));
    }
  }
}
