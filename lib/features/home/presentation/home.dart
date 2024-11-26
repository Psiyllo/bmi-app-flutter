import 'package:flutter/material.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/styles/colors.dart';
import 'package:learningapp/core/widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi, Jerel', style: AppTextStyles.heading),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: appColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Find your lessons today!', style: AppTextStyles.subtitle),
            SizedBox(height: 16),
            CustomSearchBar(), // Use o novo nome aqui.
          ],
        ),
      ),
    );
  }
}