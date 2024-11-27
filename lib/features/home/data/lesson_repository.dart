import '../domain/lesson.dart';

class LessonRepository {
  List<Lesson> getLessons() {
    return [
      Lesson(
        title: 'Figma Master Class',
        duration: '6h 30min',
        rating: 4.9,
        imageUrl: 'https://via.placeholder.com/200',
      ),
      Lesson(
        title: 'Web Design Basics',
        duration: '8h 00min',
        rating: 4.8,
        imageUrl: 'https://via.placeholder.com/200',
      ),
      Lesson(
        title: 'UI/UX Advanced',
        duration: '7h 15min',
        rating: 4.7,
        imageUrl: 'https://via.placeholder.com/200',
      ),
    ];
  }
}
