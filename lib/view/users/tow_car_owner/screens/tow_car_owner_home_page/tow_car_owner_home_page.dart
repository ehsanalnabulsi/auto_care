import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/tow_car_owner/cubits/cubit/tow_car_owner_home_page_cubit.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/buttons_builder.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/drawer.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/get_current_location_button.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/loading_page_builder.dart';
import 'package:auto_care/view/users/tow_car_owner/screens/tow_car_owner_home_page/map_widget_builder.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TowCarOwnerHomePage extends StatelessWidget {
  const TowCarOwnerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<DrawerControllerState> drawerKey =
        GlobalKey<DrawerControllerState>();

    return BlocProvider(
      create: (context) => TowCarOwnerHomePageCubit()..getCurrentLocation(),
      child: BlocConsumer<TowCarOwnerHomePageCubit, TowCarOwnerHomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          LatLng initialMarker = const LatLng(0, 0);
          if (state is GetCurrentLocationSuccessState) {
            initialMarker = LatLng(
                state.locationData.latitude!, state.locationData.longitude!);
          }
          var cubit = context.read<TowCarOwnerHomePageCubit>();
          return ConditionalBuilder(
              condition: state is GetCurrentLocationLoadingState,
              builder: (context) => const LoadingPageBuilder(),
              fallback: (context) => ConditionalBuilder(
                    condition: state is GetCurrentLocationErrorState,
                    builder: (context) =>
                        GetCurrentLocationButton(cubit: cubit),
                    fallback: (context) => Scaffold(
                        key: scaffoldKey,
                        drawer: TowCarOwnerHomePageDrawer(drawerKey: drawerKey),
                        body: PageBodyBuilder(
                            mapController: mapController,
                            initialMarker: initialMarker,
                            scaffoldKey: scaffoldKey,
                            cubit: cubit)),
                  ));
        },
      ),
    );
  }
}

class PageBodyBuilder extends StatelessWidget {
  const PageBodyBuilder({
    super.key,
    required this.mapController,
    required this.initialMarker,
    required this.scaffoldKey,
    required this.cubit,
  });

  final MapController mapController;
  final LatLng initialMarker;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final TowCarOwnerHomePageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MapWidgetBuilder(
            mapController: mapController, initialMarker: initialMarker),
        ButtonsBuilder(
            scaffoldKey: scaffoldKey,
            cubit: cubit,
            mapController: mapController,
            initialMarker: initialMarker)
      ],
    );
  }
}







