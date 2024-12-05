import 'package:flutter/material.dart';
import '../../screens/calculator/bmi_calculator_screen.dart';
import '../../screens/result/bmi_result_screen.dart';
import '../../../data/models/bmi_model.dart';

class BMIRouter {
  static const calculator = '/calculator';
  static const result = '/result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case calculator:
        return MaterialPageRoute(
          builder: (_) => const BMICalculatorScreen(),
        );
      case result:
        final args = settings.arguments as BMIModel;
        return MaterialPageRoute(
          builder: (_) => BMIResultScreen(bmiModel: args),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Route not found')),
          ),
        );
    }
  }
}
