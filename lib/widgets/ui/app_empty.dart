import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/images.dart' as app_images;

class AppEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(app_images.emptyVector),
          SvgPicture.asset(app_images.arrowIcon),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Oops! no record found",
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
