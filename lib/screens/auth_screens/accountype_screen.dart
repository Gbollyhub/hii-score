import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/layout.dart' as app_layout;
import '../../helpers/palette.dart' as app_palette;
import '../../providers/auth_provider.dart';
import '../../screens/auth_screens/register_screen.dart';
import '../../widgets/layout/auth_header.dart';

class AccountTypeScreen extends StatefulWidget {
  static const routeName = '/account-type-screen';
  @override
  _AccountTypeScreenState createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  final String _headerText = "Select an account type";

  Widget accountCard(String cardTitle, String cardDescription, Color cardColor,
      Function()? tapHandler) {
    return InkWell(
      onTap: tapHandler,
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        width: double.infinity,
        decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadiusDirectional.circular(8)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                cardTitle,
                style: TextStyle(
                    color: app_palette.white,
                    fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(cardDescription,
                      maxLines: 2,
                      style: TextStyle(
                          color: app_palette.white,
                          fontSize: 14 * MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w400)),
                ),
                SvgPicture.asset(app_images.arrowIcon)
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthHeader(_headerText),
                const SizedBox(
                  height: 20,
                ),
                accountCard(
                    'Classic Account',
                    'This account is suitable for high school students',
                    app_palette.secondaryColor, () {
                  auth.saveAccountType(0);
                  Navigator.of(context)
                      .pushReplacementNamed(RegisterScreen.routeName);
                }),
                const SizedBox(
                  height: 30,
                ),
                accountCard(
                    'Professional Account',
                    'This account is suitable for professionals in an industry',
                    app_palette.primaryColor, () {
                  auth.saveAccountType(1);
                  Navigator.of(context).pushNamed(RegisterScreen.routeName);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
