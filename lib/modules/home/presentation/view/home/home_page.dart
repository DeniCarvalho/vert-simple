import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../internationalization/internationalization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Text(
          'welcome'.i18n(context),
          style: TextStyle(
            fontSize: 30.fontSize,
          ),
        ),
      ),
    );
  }
}
