import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_product_state.dart';

// enum Status { createRequest, pending, setAppointment ,}

class AddNewProductCubit extends Cubit<AddNewProductState> {
  AddNewProductCubit() : super(AddNewProductInitial());
  static AddNewProductCubit get(context) => BlocProvider.of(context);
  late List brands;
  late List<String> brandsNames;
  late int selectedBrand;
  late List carsModels;
  late int selectedCarModel;
  late List<String> modelsNames;
  late List products;
  late List productsNames;
  late List<int> selectedProducts;

  void getPartsSupplierBrands() async {
    emit(GetBrandsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    final response = await DioHelper.get(
      getStoreBrands,
      token: 'JWT $token',
    );

    brands = response.data;
    brandsNames =
        brands.map((item) => item['name'].toString()).toSet().toList();
    emit(GetBrandsSuccessState());
  }

  void getCarModelBySelectedBrand(value) async {
    emit(GetCarModelsLoadingState());
    for (Map<String, dynamic> brand in brands) {
      if (brand['name'] == value) {
        selectedBrand = brand['brands'];
      }
    }
    await DioHelper.get(carModelsURL, query: {'brand': selectedBrand})
        .then((value) {
      carsModels = value.data;
      modelsNames =
          carsModels.map((item) => item['name'].toString()).toSet().toList();

      emit(GetCarModelsSuccessState());
    }).catchError((onError) {
      emit(GetCarModelsErrorState());
    });
  }

  void updateSelectedCarModel(value) async {
    emit(UpdateSelectedCarModelsLoadingState());
    for (Map<String, dynamic> carModel in carsModels) {
      if (carModel['name'] == value) {
        selectedCarModel = carModel['id'];
      }
    }
    print(selectedCarModel);
    getProducts();
    emit(UpdateSelectedCarModelsSuccessState());
  }

  void getProducts() async {
    emit(GetProductsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    await DioHelper.get(getProductsURL, token: 'JWT $token').then((value) {
      products = value.data;
      productsNames = products
          .map((item) => item['productName'].toString())
          .toSet()
          .toList();

      print(products);
      print(productsNames);
      emit(GetProductsSuccessState());
    }).catchError((onError) {
      emit(GetProductsErrorState());
    });
  }

  void updateSelectedProducts(brandNames) {
    emit(UpdateSelectedProductsLoadingState());
    List<int> productsIds = [];
    for (String brandName in brandNames) {
      Map<String, dynamic>? product =
          products.firstWhere((element) => element['productName'] == brandName);
      productsIds.add(product?['productId']);
    }
    selectedProducts = productsIds;
    print(selectedProducts);
    emit(UpdateSelectedProductsSuccessState());
  }

  void addNewProduct({
    required int carModel,
    required List<int> selectedProducts,
  }) async {
    emit(AddNewProductLoadingState());
    FormData basicInfoFormData =
        FormData.fromMap({'CarModel': carModel, 'productId': selectedProducts});

    try {
      emit(AddNewProductLoadingState());
      String? token = CacheHelper.getString(key: 'token');
      final response = await DioHelper.postForm(addNewProductURL,
          data: basicInfoFormData, token: 'JWT $token');

      emit(AddNewProductSuccessState(response));
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout) {
        emit(AddNewProductErrorState(error.message));
      } else if (error.type == DioExceptionType.receiveTimeout) {
        emit(AddNewProductErrorState(error.message));
      } else if (error.response != null) {
        switch (error.response!.statusCode) {
          case 400:
            emit(AddNewProductErrorState(error.message));
            break;
          case 401:
            emit(AddNewProductErrorState(error.message));
            break;
          case 404:
            emit(AddNewProductErrorState(error.message));
            break;
          default:
            emit(AddNewProductErrorState(error.message));
        }
      } else {
        emit(AddNewProductErrorState(error.message));
      }
    } catch (error) {
      emit(AddNewProductErrorState(null));
    }
  }
}
