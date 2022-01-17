import 'package:flutter/material.dart';

import '../helpers/images.dart' as app_images;
import 'utility_screens/dashboard_screen.dart';

class DummyScreen extends StatefulWidget {
  static const routeName = '/dashboard-screen';
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(app_images.backgroundImage),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
                elevation: 0,
                backgroundColor: Colors.red,
                title: Text("Dummy")),
          ),
          body: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(DashboardScreen.routeName);
                  },
                  child: Text("Dummy"))),
        ));
  }
}
