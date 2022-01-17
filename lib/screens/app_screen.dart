import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hii_score/screens/utility_screens/community_screen.dart';
import 'package:hii_score/screens/utility_screens/profile_screen.dart';
import 'package:hii_score/screens/utility_screens/search_screen.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/layout.dart' as app_layout;
import '../../helpers/palette.dart' as app_palette;
import '../../screens/utility_screens/dashboard_screen.dart';
import '../../widgets/ui/app_drawer.dart';

class AppScreen extends StatefulWidget {
  static const routeName = '/app-screen';
  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final List<Map<String, Widget>> pages = [
    {'page': DashboardScreen()},
    {'page': SearchScreen()},
    {'page': SearchScreen()},
    {'page': CommunityScreen()},
    {'page': ProfileScreen()},
  ];
  int selectedPageIndex = 0;

  void selectPage(index) {
    setState(() {
      selectedPageIndex = index;
    });
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          leading: Builder(
            builder: (context) {
              return Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: app_layout.screenPadding),
                child: InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const Icon(
                      Icons.menu,
                      size: 42,
                      color: app_palette.black,
                    )),
              );
            },
          ),
          title: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            width: 40,
            height: 40,
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              'https://wdrfree.com/public/blog/Cool-Profile-Picture-16.jpg',
            ),
          ),
          actions: [
            Container(
                width: 30,
                margin: const EdgeInsets.only(right: app_layout.screenPadding),
                child: SvgPicture.asset(app_images.notificationIcon)),
          ],
        ),
        drawer: AppDrawer(),
        body: pages[selectedPageIndex]['page'],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              color: app_palette.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          height: 70,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: selectPage,
            currentIndex: selectedPageIndex,
            unselectedItemColor: app_palette.darkGrey,
            selectedItemColor: app_palette.primaryColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: SvgPicture.asset(
                    app_images.homeIcon,
                    color: selectedPageIndex == 0
                        ? app_palette.primaryColor
                        : app_palette.darkGrey,
                  )),
              BottomNavigationBarItem(
                  label: 'Search',
                  icon: SvgPicture.asset(
                    app_images.searchIcon,
                    color: selectedPageIndex == 1
                        ? app_palette.primaryColor
                        : app_palette.darkGrey,
                  )),
              BottomNavigationBarItem(
                  label: 'Statistics',
                  icon: SvgPicture.asset(
                    app_images.statsIcon,
                    color: selectedPageIndex == 2
                        ? app_palette.primaryColor
                        : app_palette.darkGrey,
                  )),
              BottomNavigationBarItem(
                  label: 'Community',
                  icon: SvgPicture.asset(
                    app_images.communityIcon,
                    color: selectedPageIndex == 3
                        ? app_palette.primaryColor
                        : app_palette.darkGrey,
                  )),
              BottomNavigationBarItem(
                  label: 'Profile',
                  icon: SvgPicture.asset(
                    app_images.profileIcon,
                    color: selectedPageIndex == 4
                        ? app_palette.primaryColor
                        : app_palette.darkGrey,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
