import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/common/cubits/register/tow_car_owner/register_tow_car_owner_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_tow_car_owner/register_tow_car_owner_avatar_full_name_row.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_tow_car_owner/register_tow_car_owner_drop_down.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_tow_car_owner/register_tow_car_owner_information_text_builder.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/email_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/password_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/phone_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_footer.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_header.dart';
import 'package:auto_care/view/widgets/custom_drop_down_button.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:auto_care/view/widgets/custom_text_field.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterTowCarOwnerPage extends StatelessWidget {
  const RegisterTowCarOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController plateNumberController = TextEditingController();
    TextEditingController carYearController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterTowCarOwnerCubit()
        ..getCities()
        ..getOrigins(),
      child: BlocConsumer<RegisterTowCarOwnerCubit, RegisterTowCarOwnerState>(
        listener: (context, state) {
          if (state is RegisterTowCarOwnerSuccessState) {
            if (state.response.statusCode == 201) {
              final snackBar = SnackBar(
                duration: const Duration(seconds: 3),
                elevation: 0,
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Register Successfully',
                  message:
                      '${state.response.statusMessage} Please Login To Continue',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Get.offAllNamed(SharedRoutes.login);
            }
          } else if (state is RegisterTowCarOwnerErrorState) {
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
          var cubit = RegisterTowCarOwnerCubit.get(context);

          return SafeArea(
            child: Scaffold(
              body: Form(
                key: formKey,
                child: ConditionalBuilder(
                  condition: state is GetOriginsLoadingState,
                  builder: (context) =>
                      const Center(child: AppProgressIndicator()),
                  fallback: (context) => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 20),
                        const RegisterHeader(
                          title: 'Please Fill Form',
                        ),
                        const SizedBox(height: 20),
                        PickAvatarAndFullNameField(
                            cubit: cubit,
                            fullNameController: fullNameController),
                        PhoneField(phoneController: phoneController),
                        EmailField(emailController: emailController),
                        PasswordField(
                            cubit: cubit,
                            passwordController: passwordController),
                        const Divider(thickness: 1, height: 24.0),
                        const TowCarInformationText(),
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
                        SelectOriginAndCoverageCity(cubit: cubit),
                        ConditionalBuilder(
                          condition: state is GetBrandsLoadingState,
                          builder: (context) => const AppProgressIndicator(),
                          fallback: (context) => ConditionalBuilder(
                              condition: state is GetBrandsSuccessState ||
                                  state is UpdateBrandSuccessState,
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 4.0),
                                    child: CustomDropDownButton(
                                      hint: 'Select Car Brand',
                                      onChanged: (value) {
                                        cubit.updateSelectedBrand(value);
                                      },
                                      items: cubit.brandsNames,
                                    ),
                                  ),
                              fallback: (context) => const SizedBox()),
                        ),
                        ConditionalBuilder(
                            condition: state is RegisterTowCarOwnerLoadingState,
                            builder: (context) => const AppProgressIndicator(),
                            fallback: (context) => PrimaryButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate() &&
                                        cubit.pickedAvatar != null) {
                                      cubit.registerTowCarOwner(
                                        fullName: fullNameController.text,
                                        phoneNumber: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        plateNumber: plateNumberController.text,
                                        carYear: carYearController.text,
                                        origin: cubit.selectedOrigin,
                                        brand: cubit.selectedBrand,
                                        coverageCity:
                                            cubit.selectedCoverageCity,
                                      );
                                    }
                                  },
                                  textButton: 'Register',
                                )),
                        const RegisterFooter()
                      ],
                    ),
                  )
                      .animate(delay: 100.ms)
                      .fadeIn()
                      .scale()
                      .move(delay: 50.ms, duration: 400.ms)
                      .shimmer(delay: 150.ms),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
