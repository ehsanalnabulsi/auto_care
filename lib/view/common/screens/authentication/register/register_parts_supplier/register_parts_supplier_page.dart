import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/core/services/location.dart';
import 'package:auto_care/view/common/cubits/register/parts_supplier/register_parts_supplier_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_parts_supplier/register_parts_supplier_avatar_full_name_row.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_parts_supplier/register_parts_supplier_avatar_store_name_row.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_parts_supplier/register_parts_supplier_drop_down.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_parts_supplier/register_parts_supplier_information_text_builder.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_parts_supplier/register_parts_supplier_select_brands.dart';
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

class RegisterPartsSupplierPage extends StatelessWidget {
  const RegisterPartsSupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController storeNameController = TextEditingController();
    TextEditingController contactNumberController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterPartsSupplierCubit, RegisterPartsSupplierState>(
      listener: (context, state) {
        // if (state is GetCurrentLocationSuccessState) {}
        if (state is RegisterPartsSupplierSuccessState) {
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
        } else if (state is RegisterPartsSupplierErrorState) {
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
        var cubit = RegisterPartsSupplierCubit.get(context);

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
                          cubit: cubit, fullNameController: fullNameController),
                      PhoneField(phoneController: phoneController),
                      EmailField(emailController: emailController),
                      PasswordField(
                          cubit: cubit, passwordController: passwordController),
                      const Divider(thickness: 1, height: 24.0),
                      const StoreInformationText(),
                      StoreAvatarAndName(
                          cubit: cubit,
                          storeNameController: storeNameController),
                      ContactNumberField(
                          contactNumberController: contactNumberController),
                      AddressField(addressController: addressController),
                      TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.primaryColor,
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await LocationService.getCurrentLocation().then(
                            (value) => Get.toNamed(
                                SharedRoutes.addStoreLocation,
                                arguments: value),
                          );
                        },
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Press To Pin Your Store Location'),
                              Icon(
                                Icons.pin_drop,
                                size: 24,
                              )
                            ]),
                      ),
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
                          condition: state is RegisterPartsSupplierLoadingState,
                          builder: (context) => const AppProgressIndicator(),
                          fallback: (context) => PrimaryButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      cubit.pickedAvatar != null &&
                                      cubit.pickedLogo != null) {
                                    cubit.registerPartsSupplier(
                                      fullName: fullNameController.text,
                                      phoneNumber: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      storeName: storeNameController.text,
                                      contactNumber:
                                          contactNumberController.text,
                                      origin: cubit.selectedOrigin,
                                      brands: cubit.selectedBrands,
                                      address: addressController.text,
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
