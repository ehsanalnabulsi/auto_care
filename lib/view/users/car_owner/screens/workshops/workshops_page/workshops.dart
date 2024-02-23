import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/users/car_owner/cubits/workshops_cubit.dart/workshops_cubit.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshops_page/leading_app_bar.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshops_page/origins_chips_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshops_page/search_button.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshops_page/specialists_chips_builder.dart';
import 'package:auto_care/view/users/car_owner/screens/workshops/workshops_page/workshops_grid_view_builder.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class WorkshopsPage extends StatelessWidget {
  const WorkshopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => WorkshopsCubit()
        ..getOrigins()
        ..getSpecialists()
        ..getUserCars()
        ..getWorkshops(),
      child: BlocConsumer<WorkshopsCubit, WorkshopsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = WorkshopsCubit.get(context);

          return ConditionalBuilder(
            condition: state is GetWorkshopsLoadingState,
            builder: (context) => Container(
              color: AppColors.whiteColor,
              child: const Center(child: AppProgressIndicator()),
            ),
            fallback: (context) => Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                leading: const LeadingAppBar(),
                title: SizedBox(
                  width: double.maxFinite,
                  child: DropdownButton(
                    isExpanded: true,
                    disabledHint: const Text('No Cars'),
                    value: cubit.selectedCar,
                    hint: const Text(
                      'Select From Cars',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                    items: cubit.userCars.map((userCar) {
                      return DropdownMenuItem<String>(
                        value: userCar['modelName'].toString(),
                        child: Text(userCar['modelName'].toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.selectedCar = value;
                      cubit.getWorkshopsByCarModel(value);
                    },
                  ),
                ),
                actions: [
                  SearchButton(scaffoldKey: scaffoldKey),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpecialistsChipsBuilder(cubit: cubit),
                    OriginsChipsBuilder(cubit: cubit),
                    const Divider(),
                    ConditionalBuilder(
                        condition: state is GetWorkshopsLoadingState,
                        builder: (context) => const AppProgressIndicator(),
                        fallback: (context) {
                          if (cubit.workshops.isEmpty) {
                            return const Center(
                                child: Text('There is No Workshops'));
                          }
                          return WorkshopsGridViewBuilder(
                              cubit: cubit);
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




