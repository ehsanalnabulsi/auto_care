import 'package:auto_care/core/constant/imports.dart';

class TowCarInformationText extends StatelessWidget {
  const TowCarInformationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Tow Car Information',
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
