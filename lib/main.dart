import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hii_score/screens/utility_screens/community_screen.dart';
import 'package:hii_score/screens/utility_screens/search_screen.dart';
import 'package:provider/provider.dart';

import 'helpers/palette.dart' as app_palette;
import 'providers/auth_provider.dart';
import 'screens/app_screen.dart';
import 'screens/auth_screens/accountype_screen.dart';
import 'screens/auth_screens/auth_screen.dart';
import 'screens/auth_screens/register_screen.dart';
import 'screens/auth_screens/verify_number_screen.dart';
import 'screens/utility_screens/dashboard_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // final barColor = const Color(0xFF577DF4);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => AuthProvider())],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'Poppins',
              primarySwatch: MaterialColor(0xFF577DF4, color),
              accentColor: MaterialColor(0xFFFF8585, color),
              textTheme: const TextTheme(
                  headline1: TextStyle(
                      color: app_palette.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  headline2: TextStyle(
                      color: app_palette.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                  headline3: TextStyle(
                      color: app_palette.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  headline4: TextStyle(
                      color: app_palette.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  subtitle1: TextStyle(
                      color: app_palette.darkGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  subtitle2: TextStyle(
                      color: app_palette.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  bodyText1: TextStyle(
                      color: app_palette.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                  bodyText2: TextStyle(
                      color: app_palette.lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  caption: TextStyle(
                      color: app_palette.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  button: TextStyle(
                      color: app_palette.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14))),
          // home: AppScreen(),
          home: auth.isAuth! ? AppScreen() : AuthScreen(),
          routes: {
            AppScreen.routeName: (ctx) => AppScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            VerifyNumberScreen.routeName: (ctx) => VerifyNumberScreen(),
            AccountTypeScreen.routeName: (ctx) => AccountTypeScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            DashboardScreen.routeName: (ctx) => DashboardScreen(),
            SearchScreen.routeName: (ctx) => SearchScreen(),
            CommunityScreen.routeName: (ctx) => CommunityScreen(),
          },
        ),
      ),
    );
  }
}
