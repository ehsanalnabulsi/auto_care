import 'package:auto_care/core/constant/routes.dart';
import 'package:auto_care/view/common/cubits/register/car_owner/register_car_owner_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_car_owner/car_owner_register_message.dart';
import 'package:auto_care/view/common/screens/authentication/register/register_car_owner/register_car_owner_field_builder.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/email_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/full_name_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/password_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/phone_field.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_footer.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/register_header.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:auto_care/view/widgets/primary_button.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterCarOwnerPage extends StatelessWidget {
  const RegisterCarOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => RegisterCarOwnerCubit(),
      child: BlocConsumer<RegisterCarOwnerCubit, RegisterCarOwnerState>(
        listener: (context, state) async {
          if (state is RegisterCarOwnerSuccessState) {
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
          } else if (state is RegisterCarOwnerErrorState) {
            final snackBar = SnackBar(
              duration: const Duration(seconds: 3),
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Something went wrong',
                message: state.errorResponse!.data.toString(),
                contentType: ContentType.failure,
              ),
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCarOwnerCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 40),
                      const RegisterHeader(
                        title: 'Please Fill Form',
                      ),
                      const SizedBox(height: 40),
                      Column(children: [
                        Row(
                          children: [
                            Expanded(
                                child: PickAvatarWidget(
                              cubit: cubit,
                            )),
                            Expanded(
                              flex: 3,
                              child: FullNameField(
                                  fullNameController: fullNameController),
                            ),
                          ],
                        ),
                        PhoneField(phoneController: phoneController),
                        EmailField(emailController: emailController),
                        PasswordField(
                            cubit: cubit,
                            passwordController: passwordController),
                      ]),
                      const SizedBox(height: 80),
                      Column(
                        children: [
                          const CarOwnerRegister(),
                          ConditionalBuilder(
                            condition: state is RegisterCarOwnerLoadingState,
                            builder: (context) => const AppProgressIndicator(),
                            fallback: (context) => PrimaryButton(
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    cubit.pickedAvatar != null) {
                                  cubit.registerCarOwner(
                                    fullName: fullNameController.text,
                                    phoneNumber: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              textButton: 'Register',
                            ),
                          ),
                          const RegisterFooter(),
                        ],
                      )
                    ],
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
