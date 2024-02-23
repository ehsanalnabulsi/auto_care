import 'dart:io';

import 'package:auto_care/core/constant/image_asset.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/users/car_owner/cubits/add_new_car/add_new_car_cubit.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';

class AddNewCar extends StatelessWidget {
  const AddNewCar({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController plateNumberController = TextEditingController();
    TextEditingController carYearController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();
    String carColor = Colors.red.toString();
    return BlocProvider(
      create: (context) => AddNewCarCubit()..getOrigins(),
      child: BlocConsumer<AddNewCarCubit, AddNewCarState>(
        listener: (context, state) {
          if (state is AddNewCarSuccessState) {
            if (state.response.statusCode == 201) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                elevation: 1,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: '${state.response.statusMessage}',
                  message: 'Your New Car is Added',
                  contentType: ContentType.success,
                ),
              );
              Get.toNamed(CarOwnerRoutes.carOwnerMainPage, arguments: 1);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          } else if (state is AddNewCarErrorState) {}
        },
        builder: (context, state) {
          var cubit = AddNewCarCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add new car'),
            ),
            body: SafeArea(
              child: ConditionalBuilder(
                condition: state is GetOriginsLoadingState,
                builder: (context) => const AppProgressIndicator(),
                fallback: (context) => Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PickAvatarWidget(cubit: cubit),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Please Fill Your Car Information'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Car Color'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 12,
                              child: CustomTextFormField(
                                  textInputType: TextInputType.number,
                                  labelText: 'Plate Number',
                                  borderRadius: 2,
                                  prefixIcon: Icons.numbers,
                                  padding: const EdgeInsets.only(left: 12.0),
                                  controller: plateNumberController),
                            ),
                            Expanded(
                              flex: 10,
                              child: CustomTextFormField(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titleTextStyle: const TextStyle(
                                                fontSize: 21,
                                                color: AppColors.primaryColor),
                                            title: const Center(
                                              child: Text(
                                                  'Pick Car Manufactured Year'),
                                            ),
                                            content: SizedBox(
                                              width: 300,
                                              height: 300,
                                              child: YearPicker(
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime(2024),
                                                selectedDate: DateTime(2023),
                                                onChanged: (DateTime dateTime) {
                                                  carYearController.text =
                                                      dateTime.year.toString();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  padding:
                                      const EdgeInsets.only(right: 12, left: 6),
                                  textInputType: TextInputType.none,
                                  labelText: 'Car Year',
                                  borderRadius: 2,
                                  prefixIcon: Icons.date_range,
                                  controller: carYearController),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialColorPicker(
                              allowShades: false,
                              circleSize: 48,
                              colors: const [
                                Colors.blue,
                                Colors.green,
                                Colors.grey,
                                Colors.amberAccent,
                                Colors.red,
                                Colors.brown,
                              ],
                              onColorChange: (Color color) {
                                carColor = color.value.toString();
                                // Handle color changes
                              },
                              onMainColorChange: (color) {
                                carColor = color!.value.toString();
                              },
                              selectedColor: Colors.white),
                        ),
                        CustomDropDownButton(
                          validator: (value) {
                            if (value == null) {
                              return 'Must Selected';
                            }
                            return null;
                          },
                          hint: 'Select Car Origin',
                          onChanged: (value) {
                            cubit.getBrandsBySelectedOrigin(value);
                          },
                          items: cubit.originsNames,
                        ),
                        ConditionalBuilder(
                          condition: state is GetBrandsLoadingState,
                          builder: (context) => const AppProgressIndicator(),
                          fallback: (context) => ConditionalBuilder(
                              condition: state is GetBrandsSuccessState ||
                                  state is GetCarModelsLoadingState ||
                                  state is GetCarModelsSuccessState ||
                                  state is AddNewCarLoadingState,
                              builder: (context) => CustomDropDownButton(
                                    hint: 'Select Car Brand',
                                    onChanged: (value) {
                                      cubit.getCarModelBySelectedBrand(value);
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Must Selected';
                                      }
                                      return null;
                                    },
                                    items: cubit.brandsNames,
                                  ),
                              fallback: (context) => const SizedBox()),
                        ),
                        ConditionalBuilder(
                            condition: state is GetCarModelsLoadingState,
                            builder: (context) => const AppProgressIndicator(),
                            fallback: (context) => ConditionalBuilder(
                                condition: state is GetCarModelsSuccessState ||
                                    state is AddNewCarLoadingState,
                                builder: (context) => CustomDropDownButton(
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Must Selected';
                                        }
                                        return null;
                                      },
                                      hint: 'Select Car Model',
                                      onChanged: (value) {
                                        cubit.updateSelectedCarModel(value);
                                      },
                                      items: cubit.modelsNames,
                                    ),
                                fallback: (context) => const SizedBox())),
                        ConditionalBuilder(
                          condition: state is AddNewCarLoadingState,
                          builder: (context) => const AppProgressIndicator(),
                          fallback: (context) => PrimaryButton(
                            onPressed: () {
                              // if (formKey.currentState!.validate() &&
                              //     cubit.pickedAvatar != null) {
                              //   cubit.addNewCar(
                              //       plateNumber: plateNumberController.text,
                              //       carColor: carColor,
                              //       carYear: carYearController.text,
                              //       brand: cubit.selectedBrand,
                              //       origin: cubit.selectedOrigin,
                              //       model: cubit.selectedCarModel);
                              // }
                              cubit.sendMobileToken();
                            },
                            textButton: 'Add Car',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PickAvatarWidget extends StatelessWidget {
  const PickAvatarWidget({
    super.key,
    required this.cubit,
  });

  final AddNewCarCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => cubit.pickAvatar(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: Center(
            child: Stack(fit: StackFit.expand, children: [
              SizedBox(
                // width: MediaQuery.of(context).size.width - 40,
                height: 240,
                child: ConditionalBuilder(
                    condition: cubit.pickedAvatar != null,
                    builder: (context) => Image.file(
                          File(
                            cubit.pickedAvatar!.path,
                          ),
                          fit: BoxFit.cover,
                        ),
                    fallback: (context) => Image.asset(ImageAsset.carImage)),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: const Icon(Icons.add_a_photo,
                      color: AppColors.whiteColor, size: 24.0),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
