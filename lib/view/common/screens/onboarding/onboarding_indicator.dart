import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/data/static.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.onboardingController,
  });

  final PageController onboardingController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: onboardingController,
      count: onboardingList.length,
      effect: const ExpandingDotsEffect(
        dotHeight: 8.0,
        dotWidth: 12,
        activeDotColor: AppColors.primaryColor,
        spacing: 6.0,
        expansionFactor: 2,
        dotColor: AppColors.greyColor,
      ),
    );
  }
}
