import 'package:auto_care/view/widgets/logo.dart';

import '../../../../core/constant/imports.dart';
import 'onboarding_builder_widget.dart';
import 'onboarding_buttons.dart';
import 'onboarding_indicator.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    var onboardingController = PageController();
    return Scaffold(
      body: OnboardingBody(onboardingController: onboardingController),
    );
  }
}

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    super.key,
    required this.onboardingController,
  });

  final PageController onboardingController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 60),
          const SizedBox(height: 160, child: LogoImage()),
          const SizedBox(height: 30),
          Expanded(
            flex: 3,
            child:
                OnboardingBuilder(onboardingController: onboardingController),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                OnboardingIndicator(onboardingController: onboardingController),
                const SizedBox(height: 20),
                const GoToLoginPageButton(),
                const SizedBox(height: 3.0),
                const GoToRegisterPageButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
