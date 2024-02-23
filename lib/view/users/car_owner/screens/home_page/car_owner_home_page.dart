import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/home_page_cubit/car_owner_home_page_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/widgets/explore_parts_suppliers_text.dart';
import 'package:auto_care/view/users/car_owner/screens/widgets/explore_workshops_text.dart';
import 'package:auto_care/view/users/car_owner/screens/widgets/parts_suppliers_card_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/widgets/workshops_card_builder.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class CarOwnerHomePage extends StatelessWidget {
  const CarOwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarOwnerHomePageCubit()..getData(),
      // ..getSliderImages()
      // ..getWorkshops(),
      // ..getPartsSuppliers(),
      child: BlocConsumer<CarOwnerHomePageCubit, CarOwnerHomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CarOwnerHomePageCubit.get(context);
          return Scaffold(
              floatingActionButton: const MyFloatingActionButton(),
              appBar: AppBar(
                title: const Text('Home Page'),
              ),
              body: SingleChildScrollView(
                child: ConditionalBuilder(
                    condition: state is GetDataLoadingState,
                    builder: (context) =>
                        const Center(child: AppProgressIndicator()),
                    fallback: (context) => ConditionalBuilder(
                        condition: state is GetDataErrorState,
                        builder: (context) => Center(
                              child: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.refresh),
                                  label: const Text(
                                      'Cant Get Data\nPress To Retry')),
                            ),
                        fallback: (context) =>
                            CarOwnerHomePageBody(cubit: cubit))),
              ));
        },
      ),
    );
  }
}

class CarOwnerHomePageBody extends StatelessWidget {
  const CarOwnerHomePageBody({
    super.key,
    required this.cubit,
  });

  final CarOwnerHomePageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CarouselSlider.builder(
                itemCount: cubit.sliderImages.length,
                itemBuilder: (context, index, realIndex) => SizedBox(
                      height: 220,
                      width: double.maxFinite,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        elevation: 4.0,
                        shadowColor: AppColors.primaryColor.withOpacity(0.4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image(
                            image: NetworkImage(cubit.sliderImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                options: CarouselOptions(
                  height: 220,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOutCirc,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  onPageChanged: (x, y) {},
                  scrollDirection: Axis.horizontal,
                ))),
        const Divider(thickness: 1.0),
        const ExploreWorkshopsText(),
        ConditionalBuilder(
            condition: cubit.workshops.isEmpty,
            builder: (context) => const Center(
                  child: Text('There Is No Workshops'),
                ),
            fallback: (context) => WorkshopsCardBuilder(cubit: cubit)),
        const ExplorePartsSupplierText(),
        ConditionalBuilder(
            condition: cubit.partsSuppliers.isEmpty,
            builder: (context) => const Center(
                  child: Text('There Is No Parts Suppliers'),
                ),
            fallback: (context) => PartsSuppliersCardBuilder(cubit: cubit)),
      ],
    );
  }
}
