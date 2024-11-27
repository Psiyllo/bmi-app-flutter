import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static const heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const subtitlePrimary = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textPrimary);
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimary);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary);

  static const subtitleSecondary = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
