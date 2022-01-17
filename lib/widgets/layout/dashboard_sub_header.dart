import 'package:flutter/material.dart';

class DashboardSubHeader extends StatelessWidget {
  final String headerText;
  DashboardSubHeader(this.headerText);
  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}
