import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/data/static.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_cubit.dart';
import 'package:auto_care/view/users/car_owner/cubits/parts_suppliers_cubit/parts_suppliers_state.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PartsSuppliers extends StatelessWidget {
  const PartsSuppliers({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => PartsSuppliersCubit()..getPartsSuppliers(),
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
                    condition: state is GetPartsSuppliersLoadingState,
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
    List<String> categories = ['all'];
    for (var product in products) {
      String category = product['category'];
      if (!categories.contains(category)) {
        categories.add(category);
      }
    }
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChipsChoice<int>.single(
            wrapped: false,
            alignment: WrapAlignment.start,
            value: cubit.selectedCategoryIndex,
            onChanged: (val) {
              cubit.updateSelectedCategory(val);
            },
            choiceItems: C2Choice.listFrom<int, String>(
              source: categories,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            choiceStyle: C2ChipStyle.filled(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.greyColor,
              selectedStyle: C2ChipStyle.filled(color: AppColors.primaryColor),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
            child: ListView.builder(
              itemCount: products.length,
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
                                products[index]['image'],
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
                                    products[index]['title'],
                                    style: theme.titleMedium,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    'Category: ${products[index]['category']}',
                                    style: theme.titleSmall,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    'Price: ${products[index]['price'].toString()}',
                                    style: theme.titleSmall,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                  ),
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: products[index]['rating']
                                        ['rate'],
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star_rounded,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                    itemSize: 24.0,
                                  )
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
          // ChipsChoice<int>.single(
          //   wrapped: false,
          //   alignment: WrapAlignment.start,
          //   value: cubit.selectedCategoryIndex,
          //   onChanged: (val) {
          //     cubit.updateSelectedCategory(val);
          //   },
          //   choiceItems: C2Choice.listFrom<int, String>(
          //     source: categories,
          //     value: (i, v) => i,
          //     label: (i, v) => v,
          //   ),
          //   choiceStyle: C2ChipStyle.filled(
          //     borderRadius: BorderRadius.circular(10),
          //     color: AppColors.greyColor,
          //     selectedStyle: C2ChipStyle.filled(color: AppColors.primaryColor),
          //   ),
          // ),

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
                    cubit.getPartsSupplierProducts(
                        cubit.partsSuppliers[index]['user_id']);
                    Get.toNamed(CarOwnerRoutes.storeDetails, arguments: {
                      'partsSupplierDetails': cubit.partsSuppliers[index],
                      'partsSupplierProducts': cubit.partsSupplierProducts
                    });
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: cubit.partsSuppliers[index]['logo'] == null
                            ? Image.asset(
                                ImageAsset.defaultImage,
                                fit: BoxFit.cover,
                                width: 250,
                              )
                            : Image.network(
                                cubit.partsSuppliers[index]['logo'],
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
