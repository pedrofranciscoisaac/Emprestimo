import 'package:flutter/material.dart';
import 'package:memstuff_final/core/app_const.dart';
import 'package:memstuff_final/core/app_theme.dart';
import 'package:memstuff_final/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kTitleHome,
      theme: kAppTheme,
      home: HomePage(),
    );
  }
}
