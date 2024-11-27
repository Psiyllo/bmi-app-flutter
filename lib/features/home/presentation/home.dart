import 'package:flutter/material.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/styles/colors.dart';
import 'package:learningapp/core/widgets/discover_banner.dart';
import 'package:learningapp/core/widgets/lesson_card.dart';
import 'package:learningapp/core/widgets/search_bar.dart';
import '../data/lesson_repository.dart';
import '../domain/lesson.dart';

class HomeScreen extends StatelessWidget {
  final LessonRepository repository = LessonRepository();

  @override
  Widget build(BuildContext context) {
    final List<Lesson> popularLessons = repository.getLessons();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Hi, Jerel', style: AppTextStyles.heading),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Find your lessons today!', style: AppTextStyles.subtitlePrimary),
            SizedBox(height: 16),
            SearchBar(),
            SizedBox(height: 24),
            DiscoverBanner(),
            SizedBox(height: 24),
            Text(
              'Popular lessons',
              style: AppTextStyles.subtitlePrimary.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: popularLessons.map((lesson) {
                  return LessonCard(
                    title: lesson.title,
                    imageUrl: lesson.imageUrl,
                    duration: lesson.duration,
                    rating: lesson.rating,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
