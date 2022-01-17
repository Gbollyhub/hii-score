import 'package:flutter/material.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/palette.dart' as app_palette;

class AppDropDown extends StatelessWidget {
  final String? controller;
  final String? labelText;
  final String? defaultText;
  AppDropDown({
    @required this.controller,
    @required this.labelText,
    @required this.defaultText,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          if (controller! != "0")
            Container(
                margin: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  labelText!,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: app_palette.darkGrey),
                )),
          Row(
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
          const SizedBox(
            height: 13,
          ),
          const Divider(
            color: app_palette.darkGrey,
            height: 10,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}
