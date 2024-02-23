import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_state.dart';

class PartsSuppliersCubit extends Cubit<PartsSuppliersState> {
  PartsSuppliersCubit() : super(PartsSuppliersInitialState());
  static PartsSuppliersCubit get(context) => BlocProvider.of(context);
  List partsSuppliers = [];
  List partsSupplierProducts = [];
  // bool isSearching = false;

  int? selectedCategoryIndex;
  void updateSelectedCategory(value) {
    selectedCategoryIndex = value;
    emit(UpdateSelectedCategory());
  }

  void getOrigins() {
    DioHelper.get(originsURL).then((value) => null);
  }

  void getSpecialists() {
    DioHelper.get(specialistsURL).then((value) => null);
  }

  void getPartsSupplierProducts(int id) async {
    partsSupplierProducts = [];
    try {
      emit(GetPartsSupplierProductsLoadingState());

      final response = await DioHelper.get(partsSupplierProductURL,
          query: {'partSupplierId': id});
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

  void getPartsSuppliers() async {
    try {
      emit(GetPartsSuppliersLoadingState());
      final response = await DioHelper.get(partsSuppliersURL);
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
}
