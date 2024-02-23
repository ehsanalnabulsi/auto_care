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
    var partsSupplierProducts = arguments['products'];

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
                child: partsSupplier['avatar'] == null
                    ? Image.asset(ImageAsset.defaultImage, fit: BoxFit.cover)
                    : Image.network(partsSupplier['avatar'], fit: BoxFit.cover),
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
                  // Text(
                  //   'Available Parts Brands: ${partsSupplier['storeBrand'].storeBrand.join(', ')}',
                  //   style: theme.titleMedium,
                  // ),
                  const Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
