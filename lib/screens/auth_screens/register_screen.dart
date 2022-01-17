import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/layout.dart' as app_layout;
import '../../helpers/palette.dart' as app_palette;
import '../../models/enums.dart' as app_enums;
import '../../providers/auth_provider.dart';
import '../../widgets/layout/auth_header.dart';
import '../../widgets/ui/app_button.dart';
import '../../widgets/ui/app_dropdown.dart';
import '../../widgets/ui/app_dropdown_sheet.dart';
import '../../widgets/ui/app_feedback_sheet.dart';
import '../../widgets/ui/app_textarea.dart';
import '../../widgets/ui/app_textfield.dart';
import '../app_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final String _feedbackText = "Registration Successful";
  final String _buttonText = "Proceed";
  final bool _isButtonActive = true;
  final String _headerText = "Let's get you started";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _address = TextEditingController();
  var stuClass = "0";
  final TextEditingController _password = TextEditingController();
  List<String>? classList = ['SS1', 'SS2', 'SS3'];

  Future<void> Register(BuildContext context) async {
    Map<String, dynamic> data = {
      'phone_number':
          Provider.of<AuthProvider>(context, listen: false).phoneNumber,
      "first_name": _firstName.text,
      "last_name": _lastName.text,
      "address": _address.text,
      "user_class": stuClass,
      "username": _username.text,
      "password": _password.text,
      "account_type":
          Provider.of<AuthProvider>(context, listen: false).accountType,
    };
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.setLoader(true);
    final bool response = await auth.register(data);

    if (response) {
      auth.setLoader(false);
      openFeedbackSheet(context);
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

  void goToDashBoard(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppScreen.routeName);
  }

  void openFeedbackSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return AppFeedbackSheet(_feedbackText, "Okay", goToDashBoard);
      },
    );
  }

  void setStudentClass(value) {
    setState(() {
      stuClass = value;
    });
    Navigator.of(context).pop();
  }

  void openDropDownSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return AppDropdownSheet(
          sheetHeader: "Select a class",
          sheetData: classList,
          screenHeight: 0.35,
          feedBackFunction: setStudentClass,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.77,
                  child: ListView(
                    children: [
                      AuthHeader(_headerText),
                      Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              AppTextField(
                                controller: _firstName,
                                labelText: "What's your first name?",
                                validatorType:
                                    app_enums.textFieldType.textField,
                              ),
                              AppTextField(
                                controller: _lastName,
                                labelText: "What's your last name?",
                                validatorType:
                                    app_enums.textFieldType.textField,
                              ),
                              AppTextField(
                                controller: _username,
                                labelText: "What should be your username?",
                                validatorType:
                                    app_enums.textFieldType.textField,
                              ),
                              AppTextArea(
                                controller: _address,
                                labelText: "What's your address?",
                                validatorType:
                                    app_enums.textFieldType.textField,
                              ),
                              GestureDetector(
                                onTap: () {
                                  openDropDownSheet(context);
                                },
                                child: AppDropDown(
                                    controller: stuClass,
                                    labelText: "What class are you in?",
                                    defaultText: "What class are you in?"),
                              ),
                              AppTextField(
                                controller: _password,
                                labelText: "Password",
                                validatorType:
                                    app_enums.textFieldType.textField,
                                obscureText: true,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: AppButton(_buttonText, _isButtonActive, Register))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
