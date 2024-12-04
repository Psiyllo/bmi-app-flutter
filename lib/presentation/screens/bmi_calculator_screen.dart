import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/bmi_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_slider.dart';
import '/presentation/screens/bmi_result_screen.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double height = 175;
  double weight = 78;
  int age = 30;
  String gender = 'Male';

  Widget _buildValueCard(String title, String value, VoidCallback onMinus, VoidCallback onPlus) {
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
    height: 150, // Aumentei o tamanho da caixa
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
    child: Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Male',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gender == 'Male' ? AppColors.primary : Colors.black54,
              ),
            ),
            Text(
              'Female',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: gender == 'Female' ? AppColors.primary : Colors.black54,
              ),
            ),
          ],
        ),
        AnimatedAlign(
          alignment: gender == 'Male' ? Alignment.centerLeft : Alignment.centerRight,
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {
              setState(() {
                gender = gender == 'Male' ? 'Female' : 'Male';
              });
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  gender,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BMI CALCULATOR',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            // Corrigindo o botão aqui
            CustomButton(
              text: AppConstants.calculateButtonText,
              onPressed: () {
                final bmiModel = BMIModel(
                  height: height,
                  weight: weight,
                  age: age,
                  gender: gender,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMIResultScreen(bmiModel: bmiModel),
                  ),
                );
              },
              backgroundColor: AppColors.primary, // Cor de fundo do botão
              textColor: AppColors.background, // Cor do texto do botão
            ),
          ],
        ),
      ),
    ),
  );
}
}