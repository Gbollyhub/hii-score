import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../helpers/palette.dart' as app_palette;
import '../../widgets/ui/app_quotebox.dart';

class AppQuoteSlider extends StatelessWidget {
  PageController controller;
  List<String> quotesList;
  AppQuoteSlider(this.controller, this.quotesList);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller,
            itemCount: quotesList.length,
            itemBuilder: (_, i) {
              return AppQuoteBox(quotesList[i]);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: SmoothPageIndicator(
            controller: controller,
            count: quotesList.length,
            effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Color.fromRGBO(224, 227, 239, 1),
                activeDotColor: app_palette.primaryColor),
          ),
        )
      ],
    );
  }
}
