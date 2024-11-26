import 'package:flutter/material.dart';
import 'features/home/presentation/home.dart';
import 'core/styles/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appColors.primary,
        scaffoldBackgroundColor: appColors.background,
      ),
      home: HomeScreen(),
    );
  }
}
