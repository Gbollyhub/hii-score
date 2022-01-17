import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;
import '../../providers/auth_provider.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  bool isButtonActive;
  final Function(BuildContext) buttonAction;

  AppButton(this.buttonText, this.isButtonActive, this.buttonAction);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return InkWell(
      onTap: isButtonActive
          ? () {
              buttonAction(context);
            }
          : () {},
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(isButtonActive
                    ? app_images.activeButtonImage
                    : app_images.disableButtonImage),
                fit: BoxFit.cover),
            color: isButtonActive
                ? Theme.of(context).primaryColor
                : app_palette.disableButtonColor,
            borderRadius: BorderRadius.circular(8)),
        child: auth.loader == false
            ? Text(
                buttonText,
                style: Theme.of(context).textTheme.button,
              )
            : const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: app_palette.white,
                ),
              ),
      ),
    );
  }
}
