import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/cache.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_state.dart';
import 'package:auto_care/view/users/parts_supplier/cubits/add_new_product_cubit/add_new_product_cubit.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewProductCubit()..getPartsSupplierBrands(),
      child: BlocConsumer<AddNewProductCubit, AddNewProductState>(
        listener: (context, state) async {
          if (state is AddNewProductSuccessState) {
            if (state.response.statusCode == 200) {
              await CacheHelper.setString(
                      key: 'token',
                      value: state.response.data['data']['access'])
                  .then((value) {
                final snackBar = SnackBar(
                  duration: const Duration(seconds: 3),
                  elevation: 1,
                  behavior: SnackBarBehavior.fixed,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: '${state.response.data['status']}',
                    message: '${state.response.data['message']}',
                    contentType: ContentType.success,
                  ),
                );
                // CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                Get.toNamed(PartsSupplierRoutes.partsSupplierHomePage);
              });
            }
          } else if (state is AddNewProductErrorState) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 3),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Something went wrong',
                message: state.error.toString(),
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var cubit = AddNewProductCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: ConditionalBuilder(
                condition: state is GetBrandsLoadingState,
                builder: (context) => const AppProgressIndicator(),
                fallback: (context) => Column(
                  children: [
                    CustomDropDownButton(
                      hint: 'Select Parts Brand',
                      onChanged: (value) {
                        cubit.getCarModelBySelectedBrand(value);
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Must Selected';
                        }
                        return null;
                      },
                      items: cubit.brandsNames,
                    ),
                    ConditionalBuilder(
                      condition: state is GetCarModelsLoadingState,
                      builder: (context) => const AppProgressIndicator(),
                      fallback: (context) => ConditionalBuilder(
                          condition: state is GetCarModelsSuccessState ||
                              state is UpdateSelectedCarModelsSuccessState ||
                              state is GetProductsSuccessState ||
                              state is UpdateSelectedProductsSuccessState,
                          builder: (context) => CustomDropDownButton(
                                hint: 'Select Car Model',
                                onChanged: (value) {
                                  cubit.updateSelectedCarModel(value);
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Must Selected';
                                  }
                                  return null;
                                },
                                items: cubit.modelsNames,
                              ),
                          fallback: (context) => const SizedBox()),
                    ),
                    ConditionalBuilder(
                        condition: state is GetProductsSuccessState ||
                            state is UpdateSelectedProductsSuccessState,
                        builder: (context) =>
                            SelectMultiBrandField(cubit: cubit),
                        fallback: (context) => SizedBox()),
                    PrimaryButton(
                        onPressed: () {
                          cubit.addNewProduct(
                              carModel: cubit.selectedCarModel,
                              selectedProducts: cubit.selectedProducts);
                        },
                        textButton: 'Assign Products')
                  ],
                ),
              ));
        },
      ),
    );
  }
}

class SelectMultiBrandField extends StatelessWidget {
  const SelectMultiBrandField({
    super.key,
    required this.cubit,
  });

  final AddNewProductCubit cubit;

  @override
  Widget build(BuildContext context) {
    return MultiSelectBottomSheetField(
      validator: (value) {
        if (value == null) {
          return 'Selecting Product Is required';
        }
        return null;
      },
      buttonText: Text(
        'Select Product',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      selectedItemsTextStyle: const TextStyle(color: AppColors.whiteColor),
      searchable: true,
      isDismissible: true,
      chipDisplay: MultiSelectChipDisplay(
        textStyle: const TextStyle(color: AppColors.whiteColor),
        chipColor: AppColors.secondaryColor,
      ),
      buttonIcon: const Icon(Icons.arrow_drop_down),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),
      title: Text(
        'Products',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      listType: MultiSelectListType.CHIP,
      selectedColor: AppColors.primaryColor,
      items: cubit.productsNames
          .map((type) => MultiSelectItem<String>(type, type))
          .toList(),
      initialValue: const [],
      onConfirm: (onConfirm) {
        cubit.updateSelectedProducts(onConfirm);
      },
    );
  }
}
