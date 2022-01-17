import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hii_score/widgets/layout/dashboard_sub_header.dart';
import 'package:hii_score/widgets/ui/app_textfield2.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;
import '../../models/enums.dart' as app_enums;
import '../../providers/auth_provider.dart';
import '../../widgets/layout/dashboard_header.dart';

class CommunityScreen extends StatefulWidget {
  static const routeName = '/community-screen';

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final _headerText = "Community";
  final TextEditingController search = TextEditingController();
  final _subText =
      "Welcome to Hii Score community, where you can as questions or share important information.";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            DashboardHeader(_headerText, _subText),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: app_palette.tertiaryColor,
                  borderRadius: BorderRadiusDirectional.circular(10)),
              child: Column(
                children: [
                  SvgPicture.asset(app_images.communityVector),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField2(
                    controller: search,
                    labelText: "Type something...",
                    validatorType: app_enums.textFieldType.textField,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DashboardSubHeader("Featured Topics"),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: app_palette.white,
                  
                  border: Border.all(color: app_palette.midGrey)),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'How do i check my Jamb result ?',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Good day everyone, the result for the jamb examination are out but i can seem to find how to check it on the portal a g...',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '- Biola Smith (2 days ago)',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
