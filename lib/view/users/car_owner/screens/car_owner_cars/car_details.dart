import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:get/get.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map arguments = Get.arguments;
    var car = arguments['carDetails'];
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
                  Text(car['modelName']),
                  const Icon(Icons.favorite_border_outlined)
                ]),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: car['avatar'] == null
                      ? Image.asset(ImageAsset.defaultImage, fit: BoxFit.cover)
                      : Image.network(car['avatar'], fit: BoxFit.cover)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Origin: ${car['originName']}',
                      style: theme.titleMedium),
                  Text('Car Brands: ${car['brandName']}',
                      style: theme.titleMedium),
                  const SizedBox(height: 8.0),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.store_mall_directory, size: 32),
                    title: const Text('Discover Related Workshops'),
                    trailing: const Icon(Icons.arrow_right),
                    iconColor: AppColors.primaryColor,
                    textColor: AppColors.primaryColor,
                    onTap: () {
                      Get.toNamed(CarOwnerRoutes.workshops);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.store_mall_directory, size: 32),
                    title: const Text('Discover Related Parts Suppliers'),
                    trailing: const Icon(Icons.arrow_right),
                    iconColor: AppColors.primaryColor,
                    textColor: AppColors.primaryColor,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
