import 'package:flutter/material.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/palette.dart' as app_palette;

class AppDropdownSheet extends StatelessWidget {
  final String? sheetHeader;
  final List<String>? sheetData;
  final Function(String?)? feedBackFunction;
  final double? screenHeight;

  AppDropdownSheet(
      {this.sheetHeader,
      this.sheetData,
      this.feedBackFunction,
      this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * screenHeight!,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(sheetHeader!,
              style: const TextStyle(
                  color: app_palette.black,
                  fontWeight: FontWeight.w500,
                  fontSize: app_font_sizes.appDropdownHeader)),
        ),
        const SizedBox(
          height: 30,
        ),
        ...sheetData!.map((x) {
          return GestureDetector(
            onTap: () {
              feedBackFunction!(x);
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    x,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  color: app_palette.lightGrey,
                  height: 5,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }).toList()
      ]),
    );
  }
}
