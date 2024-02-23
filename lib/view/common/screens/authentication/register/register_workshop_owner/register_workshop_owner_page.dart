import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/common/cubits/register/workshop_owner/register_workshop_owner_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_workshop_owner/register_workshop_owner_avatar_full_name_row.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_workshop_owner/register_workshop_owner_avatar_workshop_name_row.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_workshop_owner/register_workshop_owner_drop_down.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_workshop_owner/register_workshop_owner_information_text_builder.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_workshop_owner/register_workshop_owner_select_brands.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_workshop_owner/selecte_workshop_location_button.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/contact_number_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/email_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/password_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/phone_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_footer.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_header.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/address_field.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterWorkshopOwnerPage extends StatelessWidget {
  const RegisterWorkshopOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController workshopNameController = TextEditingController();
    TextEditingController contactNumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterWorkshopOwnerCubit, RegisterWorkshopOwnerState>(
      listener: (context, state) {
        // if (state is GetCurrentLocationSuccessState) {}
        if (state is RegisterWorkshopOwnerSuccessState) {
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
        } else if (state is RegisterWorkshopOwnerErrorState) {
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
        var cubit = RegisterWorkshopOwnerCubit.get(context);

        return SafeArea(
          child: Scaffold(
            body: Form(
              key: formKey,
              child: ConditionalBuilder(
                condition: state is GetSpecialistsLoadingState,
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
                          cubit: cubit, fullNameController: fullNameController),
                      PhoneField(phoneController: phoneController),
                      EmailField(emailController: emailController),
                      PasswordField(
                          cubit: cubit, passwordController: passwordController),
                      const Divider(thickness: 1, height: 24.0),
                      const WorkshopInformationText(),
                      WorkshopAvatarAndNameRow(
                          cubit: cubit,
                          storeNameController: workshopNameController),
                      ContactNumberField(
                          contactNumberController: contactNumberController),
                      AddressField(addressController: addressController),
                      const SelectWorkshopLocationButton(),
                      SelectOriginAndSpecialist(cubit: cubit),
                      ConditionalBuilder(
                        condition: state is GetBrandsLoadingState,
                        builder: (context) => const AppProgressIndicator(),
                        fallback: (context) => ConditionalBuilder(
                            condition: state is GetBrandsSuccessState ||
                                state is UpdateBrandsSuccessState,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  child: SelectMultiBrandField(cubit: cubit),
                                ),
                            fallback: (context) => const SizedBox()),
                      ),
                      ConditionalBuilder(
                          condition: state is RegisterWorkshopOwnerLoadingState,
                          builder: (context) => const AppProgressIndicator(),
                          fallback: (context) => PrimaryButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      cubit.pickedAvatar != null &&
                                      cubit.pickedLogo != null) {
                                    cubit.registerWorkshopOwner(
                                      fullName: fullNameController.text,
                                      phoneNumber: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      workshopName: workshopNameController.text,
                                      contactNumber:
                                          contactNumberController.text,
                                      address: addressController.text,
                                      specialist: cubit.selectedSpecialist,
                                      origin: cubit.selectedOrigin,
                                      brands: cubit.selectedBrands,
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
    );
  }
}
