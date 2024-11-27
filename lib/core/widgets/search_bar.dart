import 'package:flutter/material.dart';
import '../../../core/styles/colors.dart'; 

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search now...',
        prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
