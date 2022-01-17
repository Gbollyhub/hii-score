import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/images.dart' as app_images;
import '../../helpers/palette.dart' as app_palette;
import '../../providers/auth_provider.dart';
import '../../widgets/layout/dashboard_header.dart';
import '../../widgets/layout/dashboard_sub_header.dart';
import '../../widgets/ui/app_examkit_box.dart';
import '../../widgets/ui/app_examkit_box2.dart';
import '../../widgets/ui/app_quote_slider.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard-screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _headerText = "Hii Brenda!";

  final _subText = "Today is a great day to learn something!";

  final controller = PageController();
  int currentPage = 0;
  late Timer _timer;

  List<String> quotesList = [
    'Education is the most powerful weapon which you can use to change the world',
    'Education is what remains after one has forgotten what one has learned in school',
    'Live as if you were to die tomorrow. Learn as if you were to live forever',
    'Develop a passion for learning. If you do, you will never cease to grow.'
  ];
  Future autoPlayQuote() async {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        if (currentPage < quotesList.length) {
          currentPage++;
        } else {
          currentPage = 0;
        }
      });
      controller.animateToPage(currentPage,
          duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoPlayQuote();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DashboardHeader(
                "Hii " +
                    auth.user['first_name'][0].toUpperCase() +
                    auth.user['first_name'].substring(1) +
                    " !",
                _subText),
          ),
          const SizedBox(
            height: 30,
          ),
          AppQuoteSlider(controller, quotesList),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DashboardSubHeader("Examinations Kit"),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppExamKitBox("Jamb", 200, app_images.examKit1Bg, 0.4,
                        app_palette.examKit1),
                    AppExamKitBox("Waec", 200, app_images.examKit2Bg, 0.8,
                        app_palette.examKit2),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppExamKitBox2(
                        "Others Exams",
                        'Over 200 available examinatons',
                        app_images.examKit3Bg,
                        app_palette.examKit3),
                    AppExamKitBox2(
                        "Market Place",
                        'Explore and buy academic resources',
                        app_images.examKit4Bg,
                        app_palette.examKit4),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
