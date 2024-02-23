import 'package:auto_care/core/constant/colors.dart';
import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/view/common/cubits/login/login_cubit.dart';
import 'package:auto_care/view/common/screens/authentication/login/login_button.dart';
import 'package:auto_care/view/common/screens/authentication/login/login_page_fields.dart';
import 'package:auto_care/view/common/screens/authentication/login/login_page_footer.dart';
import 'package:auto_care/view/common/screens/authentication/widgets/password_field.dart';
import 'package:auto_care/view/widgets/app_progress_indicator.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({
    super.key,
    required this.phoneController,
    required this.cubit,
    required this.state,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController phoneController;
  final LoginCubit cubit;
  final LoginState state;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Login',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: AppColors.primaryColor),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Please Sign In To Continue',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            PhoneNumberFormField(phoneController: phoneController),
            PasswordField(cubit: cubit, passwordController: passwordController),
            ConditionalBuilder(
              condition: state is LoginLoadingState,
              builder: (context) => const AppProgressIndicator(),
              fallback: (context) => LoginButton(
                  formKey: formKey,
                  cubit: cubit,
                  phoneController: phoneController,
                  passwordController: passwordController),
            )
          ],
        ),
        const LoginPageFooter(),
      ],
    );
  }
}
