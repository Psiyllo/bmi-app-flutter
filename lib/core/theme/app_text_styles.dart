import 'package:flutter/material.dart';
import 'package:learningapp/core/theme/app_colors.dart';

class AppTextStyles {
  static const titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const bodyLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  
  static const valueStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}