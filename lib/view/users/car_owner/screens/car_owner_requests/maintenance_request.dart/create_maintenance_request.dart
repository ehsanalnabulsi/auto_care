import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/create_maintenance_request_cubit/create_maintenance_request_cubit.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:get/get.dart';
import 'package:select_card/select_card.dart';

class CreateMaintenanceRequest extends StatelessWidget {
  const CreateMaintenanceRequest({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    return BlocProvider(
      create: (context) => CreateMaintenanceRequestCubit()..getUserCars(),
      child: BlocConsumer<CreateMaintenanceRequestCubit,
          CreateMaintenanceRequestState>(
        listener: (context, state) async {
          if (state is CreateMaintenanceRequestSuccessState) {
            if (state.response.statusCode == 200) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                elevation: 1,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Request Sent',
                  message: '${state.response.statusMessage}',
                  contentType: ContentType.success,
                ),
              );
              // CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Get.toNamed(CarOwnerRoutes.carOwnerMainPage, arguments: 2);
            }
          } else if (state is CreateMaintenanceRequestErrorState) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 3),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Something went wrong',
                message: '${state.error}',
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var cubit = CreateMaintenanceRequestCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Maintenance'),
            ),
            body: SingleChildScrollView(
                child: Form(
              child: ConditionalBuilder(
                  condition: state is GetUserCarsSuccessState &&
                      cubit.userCars.isEmpty,
                  builder: (context) => Center(
                        child: TextButton.icon(
                          icon: const Icon(
                            Icons.add,
                            size: 35,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () {
                            Get.toNamed(CarOwnerRoutes.addNewCar);
                          },
                          label: const Text(
                            'Dont Have Requests , Go to Add New Car',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                  fallback: (context) => ConditionalBuilder(
                        condition: state is GetUserCarsLoadingState,
                        builder: (context) => const Center(
                          child: AppProgressIndicator(),
                        ),
                        fallback: (context) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SelectGroupCard(context,
                                  titles: cubit.userCarsNames,
                                  contents: cubit.userCarsPlatesNumber,
                                  imageSourceType: ImageSourceType.network,
                                  images: cubit.userCarsImages,
                                  titleTextColor: AppColors.primaryColor,
                                  contentTextColor: Colors.black,
                                  cardBackgroundColor: AppColors.greyColor,
                                  cardSelectedColor: AppColors.primaryColor,
                                  // radius: 5,
                                  ids: cubit.userCarsIds, onTap: (title, id) {
                                cubit.getWorkshopsByCarModel(id);
                                debugPrint(id);
                                debugPrint(title);
                              }),
                            ),
                            ConditionalBuilder(
                                condition: state is GetWorkshopsSuccessState ||
                                    state is UpdateSelectedWorkshopState,
                                builder: (context) => CustomDropDownButton(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Must Selected';
                                        }
                                        return null;
                                      },
                                      hint: 'Select Workshop',
                                      onChanged: (value) {
                                        cubit.updateSelectedWorkshop(value);
                                      },
                                      items: cubit.workshopsNames,
                                    ),
                                fallback: (context) => const SizedBox()),
                            if (state is UpdateSelectedWorkshopState)
                              CustomTextFormField(
                                validator: (value) {
                                  return validateInput(
                                      value, 0, 255, 'description');
                                },
                                textInputType: TextInputType.text,
                                controller: descriptionController,
                                hintText: 'Maintenance Description',
                                maxLines: 5,
                                labelText: 'Maintenance Description',
                              ),
                            ConditionalBuilder(
                                condition: state
                                    is CreateMaintenanceRequestLoadingState,
                                builder: (context) =>
                                    const AppProgressIndicator(),
                                fallback: (context) => PrimaryButton(
                                    onPressed: () {
                                      if (cubit.selectedCar != null &&
                                          cubit.selectedWorkshop != null) {
                                        cubit.createMaintenanceRequest(
                                            carId: cubit.selectedCar!,
                                            workshopId: cubit.selectedWorkshop!,
                                            description:
                                                descriptionController.text);
                                      }
                                    },
                                    textButton: 'Send Request'))
                          ],
                        ),
                      )),
            )),
          );
        },
      ),
    );
  }
}
