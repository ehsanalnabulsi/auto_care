import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:auto_care/core/constant/imports.dart';

class ProductDetails extends StatelessWidget {
  final dynamic product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              foregroundColor: AppColors.primaryColor,
              pinned: true,
              expandedHeight: 240.0,
              floating: false,
              title: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Icon(Icons.favorite_border_outlined)]),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    child: Image.network(product['image'])),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(product['title'],
                        style: theme.headlineSmall!.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold)),
                    Text(
                      product['category'],
                      style: theme.headlineSmall,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: product['rating']['rate'],
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                      itemSize: 28.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Description',
                      style: theme.headlineMedium,
                    ),
                    Text(
                      product['description'],
                      style: theme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Brands Can Repair: ${product['title']}',
                      style: theme.titleMedium,
                    ),
                    const SizedBox(height: 8.0),
                    const Divider(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
