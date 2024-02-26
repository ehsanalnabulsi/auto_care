import 'package:auto_care/core/constant/end_points.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/core/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'parts_supplier_home_page_state.dart';

// enum Status { createRequest, pending, setAppointment ,}

class PartsSupplierHomePageCubit extends Cubit<PartsSupplierHomePageState> {
  PartsSupplierHomePageCubit() : super(PartsSupplierHomePageInitial());
  static PartsSupplierHomePageCubit get(context) => BlocProvider.of(context);

  late List products;

  void getProducts() async {
    emit(GetProductsLoadingState());
    String? token = CacheHelper.getString(key: 'token');
    await DioHelper.get(getAllProductsURL, token: 'JWT $token').then((value) {
      products = value.data;

      print(products);

      emit(GetProductsSuccessState());
    }).catchError((onError) {
      emit(GetProductsErrorState());
    });
  }
}
