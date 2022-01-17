import 'package:flutter/material.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/palette.dart' as app_palette;

class AppDropDown2 extends StatelessWidget {
  final String? controller;
  final String? labelText;
  final String? defaultText;
  AppDropDown2(
      {@required this.controller,
      @required this.labelText,
      @required this.defaultText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 19),
      decoration: BoxDecoration(
          color: app_palette.white,
          border: Border.all(color: app_palette.midGrey)),
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            controller! == "0" ? defaultText! : controller!,
            style: TextStyle(
                fontSize: app_font_sizes.appTextFieldSize,
                fontWeight: FontWeight.w400,
                color: controller! == "0"
                    ? app_palette.darkGrey
                    : app_palette.black),
          ),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}
