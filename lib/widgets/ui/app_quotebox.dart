import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;

class AppQuoteBox extends StatelessWidget {
  final String quote;
  AppQuoteBox(this.quote);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
          color: app_palette.primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Stack(children: [
        Positioned(top: 0, left: 0, child: Image.asset(app_images.character)),
        Positioned(bottom: 2, right: 0, child: Image.asset(app_images.plant)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'DAILY QUOTES',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(225, 225, 225, .4)),
              ),
              const SizedBox(
                height: 10,
              ),
              SvgPicture.asset(app_images.quoteIcon),
              const SizedBox(
                height: 20,
              ),
              Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: app_font_sizes.appbodySize,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
