import 'package:flutter/material.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';

class LessonDetailScreen extends StatelessWidget {
  final String title;
  final String duration;
  final double rating;
  final String imageUrl;

  LessonDetailScreen({
    required this.title,
    required this.duration,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('Lesson Details', style: AppTextStyles.heading),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(title, style: AppTextStyles.heading),
            SizedBox(height: 8),
            Text(duration, style: AppTextStyles.subtitlePrimary),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 4),
                Text(rating.toString(), style: AppTextStyles.subtitleSecondary),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Description',
              style: AppTextStyles.subtitlePrimary.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This is a detailed description of the lesson. You will learn essential skills to master this topic!',
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}
