import 'package:skbwmember/features/exercises/data/exercise_data.dart';
import 'package:skbwmember/features/exercises/domain/entities/routine.dart';
import 'package:skbwmember/features/exercises/domain/entities/workout.dart';

List<Workout> beginnerRoutine = [
  Workout(
    id: '1',
    name: 'Shoulder Workout',
    description: 'This workout is designed to build shoulder muscles.',
    imagePath: '',
    exercises: [
      exercises[0],
      exercises[0],
      exercises[0],
      exercises[0],
    ],
  ),
];

List<Routine> routines = [
  Routine(
    id: '1',
    name: 'Beginner Routine',
    workouts: beginnerRoutine,
  ),
];