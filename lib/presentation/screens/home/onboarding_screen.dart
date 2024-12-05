import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../../presentation/screens/calculator/bmi_calculator_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              // Palavra BMiDO centralizada acima da imagem
              Center(
                child: Text(
                  'BMiDO',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Imagem centralizada
              Center(
                child: Image.asset(
                  'assets/images/imagem1.png',
                  height: 400,
                ),
              ),
              const SizedBox(height: 24),
              // Título centralizado
              Center(
                child: Text(
                  AppConstants.onboardingTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 28, // Maior tamanho
                        color: Colors.white,
                      ),
                ),
              ),
              const Spacer(),
              // Botão Get Started
              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BMICalculatorScreen(),
                    ),
                  );
                },
                backgroundColor: Colors.white, // Cor branca
                textColor: AppColors.textPrimary, // Texto com cor primária
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
