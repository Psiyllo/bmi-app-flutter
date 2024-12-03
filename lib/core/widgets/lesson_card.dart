import 'package:flutter/material.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/text_styles.dart';
import 'package:learningapp/features/home/presentation/lesson_detail_screen.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String duration;
  final double rating;
  final String imageUrl;

  LessonCard({
    required this.title,
    required this.duration,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonDetailScreen(
              title: title,
              duration: duration,
              rating: rating,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.subtitlePrimary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(duration, style: AppTextStyles.caption),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(rating.toString(), style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
