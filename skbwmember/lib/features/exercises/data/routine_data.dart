import 'package:skbwmember/features/exercises/data/back_exercise_data.dart';
import 'package:skbwmember/features/exercises/domain/entities/workout.dart';
import 'package:skbwmember/features/exercises/data/chest_exercise_data.dart';

import 'bicep_exercise_data.dart';

List<Workout> regularRoutine = [
  Workout(
    id: 'back',
    name: 'Back Workouts',
    description: '',
    imagePath: 'assets/exercises/icons/back.png',
    exercises: backExercises,
  ),
  Workout(
    id: 'chest',
    name: 'Chest Workouts',
    description: '',
    imagePath: 'assets/exercises/icons/chest.png',
    exercises: chestExercises,
  ),
  Workout(
    id: 'bicep',
    name: 'Bicep Workouts',
    description: '',
    imagePath: 'assets/exercises/icons/bicep.png',
    exercises: bicepExercises,
  ),
];