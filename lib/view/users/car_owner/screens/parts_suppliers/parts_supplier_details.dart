import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:get/get.dart';

class PartsSupplierDetailsPage extends StatelessWidget {
  const PartsSupplierDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map arguments = Get.arguments;
    var partsSupplier = arguments['partsSupplierDetails'];
    List products = arguments['partsSupplierProducts'];
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240.0,
            floating: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(partsSupplier['storeName']),
                  const Icon(Icons.favorite_border_outlined)
                ]),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: partsSupplier['storeAvatar'] == null
                    ? Image.asset(ImageAsset.defaultImage, fit: BoxFit.cover)
                    : Image.network(partsSupplier['storeAvatar'],
                        fit: BoxFit.cover),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(partsSupplier['originName'],
                      style: theme.headlineSmall!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                  Text(
                    'Contact Number: ${partsSupplier['contactNumber']}',
                    style: theme.titleMedium,
                  ),
                  Text(
                    'Available Parts Brands: ${partsSupplier['storeBrand'].join(', ')}',
                    style: theme.titleMedium,
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 0.0),
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
                                        products[index]['productImage'],
                                        fit: BoxFit.contain,
                                      )),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[index]['productName'],
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
                                            'description: ${products[index]['description']}',
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
            ),
          )
        ],
      ),
    );
  }
}
