import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String headerText;
  final String subText;
  DashboardHeader(this.headerText, this.subText);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subText,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
