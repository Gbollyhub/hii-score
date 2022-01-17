import 'package:flutter/material.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/palette.dart' as app_palette;
import '../../helpers/validator.dart' as app_validator;
import '../../models/enums.dart' as app_enums;

class AppTextArea extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final Enum? validatorType;
  final bool obscureText;
  final String? initialValue;
  AppTextArea(
      {this.controller,
      this.labelText,
      this.validatorType,
      this.obscureText = false,
      this.initialValue});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        initialValue: initialValue,
        minLines:
            1, // any number you need (It works as the rows for the textarea)
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
                color: app_palette.darkGrey, fontWeight: FontWeight.w400)),
        style: const TextStyle(
            fontSize: app_font_sizes.appTextFieldSize,
            fontWeight: FontWeight.w500,
            color: app_palette.black),
        validator: (String? value) {
          switch (validatorType) {
            case app_enums.textFieldType.textField:
              app_validator.textFieldVal(value);
              break;
            case app_enums.textFieldType.emailField:
              app_validator.emailFieldVal(value);
              break;
          }
        },
        onSaved: (String? value) {
          print(value);
        },
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
