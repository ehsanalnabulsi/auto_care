import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/parts_supplier/cubits/parts_supplier_home_page_cubit/parts_supplier_home_page_cubit.dart';
import 'package:auto_care/view/users/parts_supplier/screens/drawer.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PartsSupplierHomePage extends StatelessWidget {
  const PartsSupplierHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<DrawerControllerState> drawerKey =
        GlobalKey<DrawerControllerState>();
    return BlocProvider(
      create: (context) => PartsSupplierHomePageCubit()..getProducts(),
      child:
          BlocConsumer<PartsSupplierHomePageCubit, PartsSupplierHomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PartsSupplierHomePageCubit.get(context);
          var theme = Theme.of(context).textTheme;
          return Scaffold(
              appBar: AppBar(
                title: const Text('Parts Supplier Home Page'),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(PartsSupplierRoutes.addNewProduct);
                },
                child: const Icon(Icons.add_business_rounded),
              ),
              drawer: PartsHomePageDrawer(drawerKey: drawerKey),
              body: ConditionalBuilder(
                condition: state is GetProductsLoadingState,
                builder: (context) => const AppProgressIndicator(),
                fallback: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 0.0),
                        child: ListView.builder(
                          itemCount: cubit.products.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                // Get.toNamed(CarOwnerRoutes.productDetails,
                                //     arguments: ProductDetails(
                                //       product: products[index],
                                //     )
                                //     ,);
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.all(12.0),
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            cubit.products[index]
                                                ['productImage'],
                                            fit: BoxFit.contain,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cubit.products[index]
                                                    ['productName'],
                                                style: theme.titleMedium,
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                'Category: ${cubit.products[index]['category']}',
                                                style: theme.titleSmall,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(value: true, onChanged: (value) {})
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
