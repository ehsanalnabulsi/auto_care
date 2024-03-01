import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_cubit.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_state.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';

class PartsSuppliers extends StatelessWidget {
  const PartsSuppliers({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => PartsSuppliersCubit()
        ..getSpecialists()
        ..getPartsSuppliers()
        ..getProducts(),
      child: BlocConsumer<PartsSuppliersCubit, PartsSuppliersState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PartsSuppliersCubit.get(context);
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: const Text('Discover Car Parts'),
                  bottom: TabBar(
                      indicatorColor: AppColors.secondaryColor,
                      labelColor: AppColors.whiteColor,
                      indicatorWeight: 3,
                      unselectedLabelColor:
                          AppColors.whiteColor.withOpacity(0.4),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: 'Parts Suppliers'),
                        Tab(text: 'Car Parts'),
                      ]),
                  leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back)),
                ),
                body: ConditionalBuilder(
                    condition: state is GetPartsSupplierProductsLoadingState,
                    builder: (context) =>
                        const Center(child: AppProgressIndicator()),
                    fallback: (context) => TabBarView(
                          children: [
                            PartsSuppliersTabBuilder(cubit: cubit),
                            CarPartsTabBuilder(cubit: cubit),
                          ],
                        )),
              ));
        },
      ),
    );
  }
}

class CarPartsTabBuilder extends StatelessWidget {
  const CarPartsTabBuilder({super.key, required this.cubit});
  final PartsSuppliersCubit cubit;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoriesChipsBuilder(cubit: cubit),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            child: ListView.builder(
              itemCount: cubit.partsSupplierProducts.length,
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
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                cubit.partsSupplierProducts[index]
                                    ['productImage'],
                                fit: BoxFit.contain,
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.partsSupplierProducts[index]
                                        ['productName'],
                                    style: theme.titleMedium,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    'Category: ${cubit.partsSupplierProducts[index]['category']}',
                                    style: theme.titleSmall,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'description: ${cubit.partsSupplierProducts[index]['description']}',
                                    style: theme.titleSmall,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PartsSuppliersTabBuilder extends StatelessWidget {
  const PartsSuppliersTabBuilder({
    super.key,
    required this.cubit,
  });

  final PartsSuppliersCubit cubit;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            child: GridView.builder(
              itemCount: cubit.partsSuppliers.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    cubit
                        .getPartsSupplierProducts(
                            cubit.partsSuppliers[index]['id'])
                        .then((value) {
                      Get.toNamed(CarOwnerRoutes.storeDetails, arguments: {
                        'partsSupplierDetails': cubit.partsSuppliers[index],
                        'partsSupplierProducts': cubit.partsSupplierProducts
                      });
                    });
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:
                            cubit.partsSuppliers[index]['storeAvatar'] == null
                                ? Image.asset(
                                    ImageAsset.defaultImage,
                                    fit: BoxFit.cover,
                                    width: 250,
                                  )
                                : Image.network(
                                    cubit.partsSuppliers[index]['storeAvatar'],
                                    fit: BoxFit.cover,
                                    width: 250,
                                  ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black87.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.partsSuppliers[index]['storeName'],
                                    style: theme.titleLarge!.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    cubit.partsSuppliers[index]['originName'],
                                    style: theme.titleMedium!.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'See More...',
                                style: theme.titleMedium!
                                    .copyWith(color: AppColors.secondaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 2.0, // spacing between rows
                crossAxisSpacing: 2.0, // spacing between columns
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoriesChipsBuilder extends StatelessWidget {
  const CategoriesChipsBuilder({
    super.key,
    required this.cubit,
  });

  final PartsSuppliersCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<int>.single(
      padding: const EdgeInsets.all(4),
      wrapped: false,
      alignment: WrapAlignment.start,
      value: cubit.selectedCategoryIndex,
      onChanged: (value) {
        cubit.updateSelectedSpecialist(value);
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: cubit.chipCategories,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChipStyle.filled(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        borderRadius: BorderRadius.circular(10),
        color: AppColors.greyColor,
        selectedStyle: C2ChipStyle.filled(color: AppColors.primaryColor),
      ),
    );
  }
}
