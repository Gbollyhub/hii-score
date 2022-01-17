import 'package:flutter/material.dart';
import 'package:hii_score/widgets/ui/app_button.dart';
import 'package:hii_score/widgets/ui/app_dropdown2.dart';
import 'package:hii_score/widgets/ui/app_empty.dart';
import 'package:provider/provider.dart';

import '../../models/enums.dart' as app_enums;
import '../../providers/auth_provider.dart';
import '../../widgets/layout/dashboard_header.dart';
import '../../widgets/ui/app_dropdown_sheet.dart';
import '../../widgets/ui/app_textfield2.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _headerText = "Search";
  bool _isButtonActive = false;
  final _subText = "Looking for an examination practice? Lets help you find it";
  List _searchResult = ["A"];
  final TextEditingController search = TextEditingController();
  var _selectedSubject = "0";
  final List<String>? _subjectList = [
    'English',
    'Mathematics',
    'Biology',
    'Economics',
    'Chemistry',
    'Physics'
  ];

  void setSubject(value) {
    setState(() {
      _selectedSubject = value;
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
          sheetHeader: "Select a Subject",
          sheetData: _subjectList,
          screenHeight: 0.70,
          feedBackFunction: setSubject,
        );
      },
    );
  }

  void searchApp(BuildContext ctx) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    auth.setLoader(true);
    _searchResult = [];
    auth.setLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    if (search.text.isNotEmpty) {
      setState(() {
        _isButtonActive = true;
      });
    }
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
            GestureDetector(
              onTap: () {
                openDropDownSheet(context);
              },
              child: AppDropDown2(
                  controller: _selectedSubject,
                  labelText: "Select a Subject",
                  defaultText: "Select a Subject"),
            ),
            const SizedBox(
              height: 15,
            ),
            AppTextField2(
              controller: search,
              labelText: "Type something...",
              validatorType: app_enums.textFieldType.textField,
            ),
            if (_searchResult.isNotEmpty) AppEmpty(),
            const SizedBox(
              height: 50,
            ),
            AppButton("Search", _isButtonActive, searchApp)
          ],
        ),
      ),
    );
  }
}
