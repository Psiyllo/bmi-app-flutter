import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '/../../core/constants/app_constants.dart';
import '/../../data/models/bmi_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_slider.dart';
import '../../screens/calculator/bmi_calculator_service.dart';
import '../../screens/calculator/bmi_calculator_factory.dart';
import '../../screens/result/bmi_result_screen.dart';
import '../../../data/models/bmi_model.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final BMICalculatorFactory _bmiFactory = BMICalculatorFactory();
  double height = 170.0;
  double weight = 70.0;
  int age = 30;
  String gender = 'Male';

  Widget _buildValueCard(
      String title, String value, VoidCallback onMinus, VoidCallback onPlus) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCircularButton(Icons.remove, onMinus),
              const SizedBox(width: 16),
              _buildCircularButton(Icons.add, onPlus),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.primary),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildHeightCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Height (CM)',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            height.toStringAsFixed(0),
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          CustomSlider(
            value: height,
            min: 50,
            max: 300,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                gender = 'Male';
              });
            },
            child: Text(
              'Male',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gender == 'Male' ? AppColors.primary : Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                gender = 'Female';
              });
            },
            child: Text(
              'Female',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gender == 'Female' ? AppColors.primary : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'BMiDO',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _buildValueCard(
                      'Age',
                      age.toString(),
                      () => setState(() {
                        if (age > 1) age--;
                      }),
                      () => setState(() {
                        age++;
                      }),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildValueCard(
                      'Weight (KG)',
                      weight.toStringAsFixed(0),
                      () => setState(() {
                        if (weight > 1) weight--;
                      }),
                      () => setState(() {
                        weight++;
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildHeightCard(),
              const SizedBox(height: 24),
              _buildGenderSelector(),
              const Spacer(),
              CustomButton(
                text: AppConstants.calculateButtonText,
                onPressed: () {
                  final bmiModel = _bmiFactory.createBMIModel(
                    height: height,
                    weight: weight,
                    age: age,
                    gender: gender,
                  );

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => BMIResultScreen(bmiModel: bmiModel),
                  ));
                },
                backgroundColor: AppColors.primary,
                textColor: AppColors.background,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
