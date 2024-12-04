import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/bmi_model.dart';
import '../../domain/usecases/calculate_bmi_usecase.dart';
import '../widgets/custom_button.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../data/bmi_database.dart';
import 'bmi_history_screen.dart';  // Importando a tela de histórico

class BMIResultScreen extends StatelessWidget {
  final BMIModel bmiModel;
  final calculateBMIUseCase = CalculateBMIUseCase();

  BMIResultScreen({Key? key, required this.bmiModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBMIUseCase.execute(bmiModel);
    final category = calculateBMIUseCase.getBMICategory(bmiModel);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Fundo suave
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BMI CALCULATOR',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Body Mass Index',
                  style: AppTextStyles.titleLarge,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'BMI Results',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: bmi.toStringAsFixed(0),
                              style: AppTextStyles.valueStyle.copyWith(
                                fontSize: 64,
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: '.' + bmi.toStringAsFixed(2).split('.')[1],
                              style: AppTextStyles.valueStyle.copyWith(
                                fontSize: 32,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Underweight: BMI less than 18.5\n'
                        'Normal weight: BMI 18.5 to 24.9\n'
                        'Overweight: BMI 25 to 29.9\n'
                        'Obesity: 30 to 40',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                CustomButton(
  text: AppConstants.saveResultsButtonText,
  onPressed: () async {
    try {
      // Obtendo os valores de idade, peso, altura e gênero
      int age = bmiModel.age;      // Supondo que a idade está em bmiModel
      double weight = bmiModel.weight;  // Supondo que o peso está em bmiModel
      double height = bmiModel.height;  // Supondo que a altura está em bmiModel
      String gender = bmiModel.gender;  // Supondo que o gênero está em bmiModel

      // Salva o resultado no banco de dados
      await BMIDatabase.instance.saveResult(bmi, category, age, weight, height, gender);

      // Mostra um snack bar de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Result saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navega para a tela de resultados após salvar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BMIHistoryScreen(), // Tela de histórico
        ),
      );
    } catch (e) {
      // Mostra um snack bar de erro se algo der errado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save result: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  backgroundColor: AppColors.primary,
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
