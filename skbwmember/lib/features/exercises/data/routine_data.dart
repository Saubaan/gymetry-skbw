import 'package:skbwmember/features/exercises/data/back_exercise_data.dart';
import 'package:skbwmember/features/exercises/domain/entities/workout.dart';

List<Workout> regularRoutine = [
  Workout(
    id: 'back',
    name: 'Back Workouts',
    description: '',
    imagePath: 'assets/exercises/icons/back.png',
    exercises: backExercises,
  ),
];