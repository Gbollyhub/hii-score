import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hii_score/widgets/layout/dashboard_header.dart';
import 'package:hii_score/widgets/ui/app_button.dart';
import 'package:hii_score/widgets/ui/app_dropdown.dart';
import 'package:hii_score/widgets/ui/app_textarea.dart';
import 'package:hii_score/widgets/ui/app_textfield3.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../models/enums.dart' as app_enums;
import '../../providers/auth_provider.dart';
import '../../widgets/ui/app_dropdown_sheet.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _headerText = "Profile";
  final bool _isButtonActive = false;
  final _subText = "Here are all your personal information";
  final String _buttonText = "Update Profile";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _address = TextEditingController();
  var stuClass = "0";
  final TextEditingController _password = TextEditingController();
  List<String>? classList = ['SS1', 'SS2', 'SS3'];

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

  void updateProfile(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              DashboardHeader(_headerText, _subText),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://wdrfree.com/public/blog/Cool-Profile-Picture-16.jpg"),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          app_images.cameraIcon,
                          height: 35,
                          width: 35,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      AppTextField3(
                        initialValue: auth.user['first_name'],
                        labelText: "What's your first name?",
                        validatorType: app_enums.textFieldType.textField,
                      ),
                      AppTextField3(
                        initialValue: auth.user['last_name'],
                        labelText: "What's your last name?",
                        validatorType: app_enums.textFieldType.textField,
                      ),
                      AppTextField3(
                        initialValue: auth.user['username'],
                        labelText: "What should be your username?",
                        validatorType: app_enums.textFieldType.textField,
                      ),
                      AppTextArea(
                        initialValue: auth.user['address'],
                        labelText: "What's your address?",
                        validatorType: app_enums.textFieldType.textField,
                      ),
                      GestureDetector(
                        onTap: () {
                          openDropDownSheet(context);
                        },
                        child: AppDropDown(
                            controller: auth.user['user_class'],
                            labelText: "What class are you in?",
                            defaultText: "What class are you in?"),
                      ),
                      AppTextField3(
                        controller: _password,
                        labelText: "Password",
                        validatorType: app_enums.textFieldType.textField,
                        obscureText: true,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              AppButton(_buttonText, _isButtonActive, updateProfile),
              const SizedBox(
                height: 60,
              ),
            ])));
  }
}
