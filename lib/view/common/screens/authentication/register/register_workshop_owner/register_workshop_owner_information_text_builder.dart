import 'package:auto_care/core/constant/imports.dart';
import 'package:flutter/material.dart';

class WorkshopInformationText extends StatelessWidget {
  const WorkshopInformationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Workshop Information',
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
