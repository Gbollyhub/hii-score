import 'package:flutter/material.dart';

import '../../helpers/palette.dart' as app_palette;

class AppSnackbar extends StatelessWidget {
  final String errorMessage = "sffffff";

  @override
  Widget build(BuildContext context) {
    return SnackBar(
        backgroundColor: app_palette.errorColor,
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
        ));
  }
}
