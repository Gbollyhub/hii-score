import 'package:flutter/material.dart';

import '../../helpers/palette.dart' as app_palette;

class AppExamKitBox extends StatelessWidget {
  String examTitle;
  int examFigure;
  String bg;
  double progressFigure;
  Color boxColor;

  AppExamKitBox(this.examTitle, this.examFigure, this.bg, this.progressFigure,
      this.boxColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(bg), fit: BoxFit.cover),
          color: boxColor,
          borderRadius: BorderRadius.circular(10)),
      height: 120,
      width: MediaQuery.of(context).size.width * 0.43,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            examTitle,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            examFigure.toString() + " papers",
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 5,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: app_palette.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: 5,
                ),
                FractionallySizedBox(
                  heightFactor: 1,
                  widthFactor: progressFigure,
                  child: Container(
                    decoration: BoxDecoration(
                        color: app_palette.progressBar,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
