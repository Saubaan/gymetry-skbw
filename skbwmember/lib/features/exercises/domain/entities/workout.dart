import 'package:skbwmember/features/exercises/domain/entities/exercise.dart';

class Workout {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.exercises,
  });
}