import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../helpers/font_sizes.dart' as app_font_sizes;
import '../../helpers/images.dart' as app_images;
import '../../helpers/layout.dart' as app_layout;
import '../../helpers/palette.dart' as app_palette;
import '../../providers/auth_provider.dart';
import '../../screens/auth_screens/verify_number_screen.dart';
import '../../widgets/layout/auth_header.dart';
import '../../widgets/ui/app_button.dart';
import '../app_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  const AuthScreen({Key? key}) : super(key: key);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String phoneNumberValue = "";
  TextEditingController passwordController = TextEditingController();
  final String _headerText = "What's your Mobile Number?";
  final String _buttonText = "Proceed";
  bool _isButtonActive = false;
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void _checkUserStatus(phoneNumber) {
    _isButtonActive = false;
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.checkUserStatus(phoneNumber)!.then((value) {
      if (auth.isMember!) {
        setState(() {
          _isButtonActive = false;
        });
      } else {
        setState(() {
          _isButtonActive = true;
        });
      }
    });
  }

  void _sendOTP(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.sendOTP(phoneNumberValue).then((value) {
      if (value) {
        auth.savePhoneNumber(phoneNumberValue);
        Navigator.of(context)
            .pushReplacementNamed(VerifyNumberScreen.routeName);
      }
    });
  }

  Future<void> _logUserIn(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setLoader(true);
    await auth.logUserIn(phoneNumberValue, passwordController.text);

    if (auth.isAuth!) {
      auth.setLoader(false);
      Navigator.of(context).pushNamed(AppScreen.routeName);
    } else {
      auth.setLoader(false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: app_palette.errorColor,
          content: Text(
            auth.errorMessage,
            textAlign: TextAlign.center,
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (phoneNumberValue.length == 14 && passwordController.text.length >= 5) {
      setState(() {
        _isButtonActive = true;
      });
    }
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
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    if (number.phoneNumber!.length == 14) {
                      var phoneNumber = number.phoneNumber!.substring(1);
                      _checkUserStatus(phoneNumber);
                      setState(() {
                        phoneNumberValue = phoneNumber;
                      });
                    }
                  },
                  spaceBetweenSelectorAndTextField: 20,
                  selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                      showFlags: true,
                      setSelectorButtonAsPrefixIcon: false,
                      useEmoji: true),
                  ignoreBlank: false,
                  initialValue: number,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: app_font_sizes.appTextFieldSize,
                      color: app_palette.black),
                  selectorTextStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: app_font_sizes.appTextFieldSize,
                      color: app_palette.black),
                ),
                if (!auth.isMember!)
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 20),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(
                            text:
                                'We will send a text with a verification code. Message and data rates may apply. ',
                            style: Theme.of(context).textTheme.bodyText2,
                            children: const [
                          TextSpan(
                            text: 'Learn what happens when your number changes',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: app_palette.black,
                                fontWeight: FontWeight.w400,
                                fontSize: app_font_sizes.appbodySize),
                          )
                        ])),
                  ),
                if (auth.isMember!)
                  const SizedBox(
                    height: 35,
                  ),
                if (auth.isMember!)
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: app_font_sizes.appTextFieldSize,
                        color: app_palette.black),
                    onChanged: (text) {
                      if (text.length > 5) {
                        setState(() {
                          _isButtonActive = true;
                        }); // do something with text
                      }
                    },
                  ),
                if (auth.isMember!)
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: app_font_sizes.appbodySize),
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                AppButton(_buttonText, _isButtonActive,
                    auth.isMember! ? _logUserIn : _sendOTP)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
