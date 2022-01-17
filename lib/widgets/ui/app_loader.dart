import 'package:flutter/material.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_palette.white,
      alignment: Alignment.center,
      width: double.infinity,
      child: Image.asset(app_images.loader),
    );
  }
}
