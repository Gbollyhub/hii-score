import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hii_score/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;
import '../../screens/auth_screens/auth_screen.dart';
import '../../screens/utility_screens/dashboard_screen.dart';
import '../../widgets/ui/app_button.dart';

class AppDrawer extends StatelessWidget {
  List<Map<String, dynamic>> sideLinks = [
    {
      "icon": app_images.searchIcon2,
      "title": "Search",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      }
    },
    {
      "icon": app_images.statsIcon2,
      "title": "Statistics",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
    {
      "icon": app_images.communityIcon2,
      "title": "Community",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
    {
      "icon": app_images.purchasesIcon2,
      "title": "Purchases",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
    {
      "icon": app_images.notificationIcon2,
      "title": "Notifications",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
    {
      "icon": app_images.historyIcon2,
      "title": "Payment History",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
    {
      "icon": app_images.profileIcon2,
      "title": "Profile",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
    {
      "icon": app_images.modeIcon2,
      "title": "Switch to Dark Mode",
      "route": (context) {
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
      },
    },
  ];
  Future<void> Logout(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final response = await auth.logOut();
    if (response) {
      Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 20),
                              width: 65,
                              height: 65,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://wdrfree.com/public/blog/Cool-Profile-Picture-16.jpg',
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'Hello',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: app_palette.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      auth.user['first_name'][0].toUpperCase() +
                                          auth.user['first_name'].substring(1) +
                                          " " +
                                          auth.user['last_name'][0]
                                              .toUpperCase() +
                                          auth.user['last_name'].substring(1),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: app_palette.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      auth.user['account_type'] == 0
                                          ? 'High School Account'
                                          : 'Professional Account',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: app_palette.lightGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                  ],
                ),
                Column(
                  children: [
                    ...sideLinks.map((result) {
                      return Column(
                        children: [
                          ListTile(
                            minLeadingWidth: 10,
                            leading: SvgPicture.asset(result['icon']),
                            title: Text(result['title']),
                            trailing:
                                SvgPicture.asset(app_images.arrowRightIcon),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 5,
                          )
                        ],
                      );
                    }),
                  ],
                ),
                AppButton("Logout", true, Logout),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
