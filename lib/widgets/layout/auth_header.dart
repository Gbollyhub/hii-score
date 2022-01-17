import 'package:flutter/material.dart';

import '../../helpers/images.dart' as app_images;

class AuthHeader extends StatelessWidget {
  final String headerText;

  AuthHeader(@required this.headerText);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: MediaQuery.of(context).size.height * 0.10,
          child: Image.asset(app_images.appLogo, fit: BoxFit.cover),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            headerText,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ],
    );
  }
}
