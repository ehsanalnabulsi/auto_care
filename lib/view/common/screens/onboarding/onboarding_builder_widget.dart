import 'package:auto_care/core/constant/imports.dart';
import 'package:auto_care/data/static.dart';

class OnboardingBuilder extends StatelessWidget {
  const OnboardingBuilder({
    super.key,
    required this.onboardingController,
  });

  final PageController onboardingController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: onboardingController,
      itemCount: onboardingList.length,
      itemBuilder: (context, i) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(onboardingList[i].title!,
                style: Theme.of(context).textTheme.headlineMedium),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              onboardingList[i].image!,
              height: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: double.infinity,
            child: Text(
              onboardingList[i].body!,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
