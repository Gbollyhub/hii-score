import 'package:flutter/material.dart';

class AppExamKitBox2 extends StatelessWidget {
  String kitTitle;
  String kitSub;
  String bg;
  Color boxColor;

  AppExamKitBox2(this.kitTitle, this.kitSub, this.bg, this.boxColor);

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
            kitTitle,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            kitSub,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
