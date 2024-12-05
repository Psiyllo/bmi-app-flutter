import 'package:flutter/material.dart';
import '../../screens/calculator/bmi_calculator_screen.dart';
import '../../../data/models/bmi_model.dart';

class BMICalculatorFactory {
  // Defina o método createBMIModel aqui
  BMIModel createBMIModel({
    required double height,
    required double weight,
    required int age,
    required String gender,
  }) {
    return BMIModel(
      height: height,
      weight: weight,
      age: age,
      gender: gender,
    );
  }
}
