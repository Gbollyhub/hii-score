import 'package:flutter/material.dart';
import 'package:hii_score/widgets/ui/app_button.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;

class AppFeedbackSheet extends StatelessWidget {
  final String feedbackText;
  final String buttonText;
  final bool isButtonActive = true;
  final Function(BuildContext context) feedBackFunction;
  AppFeedbackSheet(this.feedbackText, this.buttonText, this.feedBackFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Image.asset(app_images.successImage, fit: BoxFit.cover),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          feedbackText,
          style: TextStyle(
              color: app_palette.black,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
        ),
        AppButton(buttonText, isButtonActive, feedBackFunction)
      ]),
    );
  }
}
