import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/images.dart' as app_images;
import '../../helpers/layout.dart' as app_layout;
import '../../helpers/palette.dart' as app_palette;
import '../../providers/auth_provider.dart';
import '../../screens/auth_screens/accountype_screen.dart';
import '../../widgets/layout/auth_header.dart';
import '../../widgets/ui/app_button.dart';
import 'auth_screen.dart';

class VerifyNumberScreen extends StatefulWidget {
  static const routeName = '/verify-number-screen';
  @override
  _VerifyNumberScreenState createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  bool loader = false;
  final String _headerText = "Verification Code";
  final String _buttonText = "Verify";
  bool _isButtonActive = false;
  String otpValue = "";

  void verifyCode(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setLoader(true);
    auth.verifyMobileNumber(otpValue).then((response) {
      if (response) {
        auth.setLoader(false);
        Navigator.of(context).pushReplacementNamed(AccountTypeScreen.routeName);
      } else {
        auth.setLoader(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: app_palette.errorColor,
            content: Text(
              auth.errorMessage,
              textAlign: TextAlign.center,
            )));
      }
    });
  }

  Future<void> changeNumber(BuildContext ctx) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setLoader(true);
    bool response = await auth.changeNumber(auth.phoneNumber);
    if (response) {
      auth.setLoader(false);
      Navigator.of(ctx).pushReplacementNamed(AuthScreen.routeName);
    }
  }

  Future<void> resendOtp() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setLoader(true);
    bool response = await auth.resendOTP(auth.phoneNumber);
    if (response) {
      auth.setLoader(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'OTP sent successfully',
            textAlign: TextAlign.center,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(app_images.backgroundImage),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: 0,
                top: MediaQuery.of(context).size.height * 0.10,
                right: app_layout.screenPadding,
                left: app_layout.screenPadding),
            child: Column(
              children: [
                AuthHeader(_headerText),
                OTPTextField(
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: MediaQuery.of(context).size.width * 0.10,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: app_font_sizes.appTextFieldSize,
                      color: app_palette.black),
                  textFieldAlignment: MainAxisAlignment.spaceBetween,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    setState(() {
                      otpValue = pin;
                    });
                    _isButtonActive = true;
                  },
                  onChanged: (s) {},
                ),
                Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(
                            text: "Didn’t get a code for ",
                            style: Theme.of(context).textTheme.bodyText2,
                            children: [
                          TextSpan(
                            text: auth.phoneNumber,
                            style: const TextStyle(
                                color: app_palette.black,
                                fontWeight: FontWeight.w400,
                                fontSize: app_font_sizes.appbodySize),
                          ),
                          TextSpan(
                            text: " ?",
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ]))),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        changeNumber(context);
                      },
                      child: const Text("Change Number",
                          style: TextStyle(
                              color: app_palette.tertiaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: app_font_sizes.appbodySize)),
                    ),
                    const Text(" | ",
                        style: TextStyle(
                            color: app_palette.tertiaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: app_font_sizes.appbodySize)),
                    GestureDetector(
                      onTap: resendOtp,
                      child: const Text("Resend Code",
                          style: TextStyle(
                              color: app_palette.tertiaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: app_font_sizes.appbodySize)),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                AppButton(loader ? "Loading..." : _buttonText, _isButtonActive,
                    verifyCode)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
