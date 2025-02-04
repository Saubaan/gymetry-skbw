import 'package:skbwmember/features/exercises/data/back_exercise_data.dart';
import 'package:skbwmember/features/exercises/data/cardio_exercise_data.dart';
import 'package:skbwmember/features/exercises/data/forearm_exercise_data.dart';
import 'package:skbwmember/features/exercises/data/leg_exercise_data.dart';
import 'package:skbwmember/features/exercises/data/shoulder_exercise_data.dart';
import 'package:skbwmember/features/exercises/data/tricep_exercise_data.dart';
import 'package:skbwmember/features/exercises/domain/entities/workout.dart';
import 'package:skbwmember/features/exercises/data/chest_exercise_data.dart';

import 'bicep_exercise_data.dart';

List<Workout> workoutRoutines = [
  // chest workout
  Workout(
    id: 'chest',
    name: 'Chest Workouts',
    imagePath: 'assets/exercises/icons/chest.png',
    exercises: chestExercises,
  ),
  // back workout
  Workout(
    id: 'back',
    name: 'Back Workouts',
    imagePath: 'assets/exercises/icons/back.png',
    exercises: backExercises,
  ),
  // bicep workout
  Workout(
    id: 'bicep',
    name: 'Bicep Workouts',
    imagePath: 'assets/exercises/icons/bicep.png',
    exercises: bicepExercises,
  ),
  // tricep workout
  Workout(
    id: 'tricep',
    name: 'Tricep Workouts',
    imagePath: 'assets/exercises/icons/tricep.png',
    exercises: tricepExercises,
  ),
  // shoulder workout
  Workout(
    id: 'shoulder',
    name: 'Shoulder Workouts',
    imagePath: 'assets/exercises/icons/shoulder.png',
    exercises: shoulderExercises,
  ),
  // forearm workout
  Workout(
    id: 'forearm',
    name: 'Forearm Workouts',
    imagePath: 'assets/exercises/icons/forearm.png',
    exercises: forearmExercises,
  ),
  // leg workout
  Workout(
    id: 'leg',
    name: 'Leg Workouts',
    imagePath: 'assets/exercises/icons/leg.png',
    exercises: legExercises,
  ),
  // cardio workout
  Workout(
    id: 'cardio',
    name: 'Cardio Workouts',
    imagePath: 'assets/exercises/icons/cardio.png',
    exercises: cardioExercises,
  ),

  // beginner workout day 1
  Workout(
    id: 'beginner',
    name: 'Beginner Day 1',
    imagePath: 'assets/exercises/icons/day_1.png',
    exercises: [
      chestExercises[3],
      chestExercises[4],
      chestExercises[5],
      chestExercises[9],
      backExercises[0],
      backExercises[1],
      backExercises[2],
      backExercises[11],
      bicepExercises[2],
      bicepExercises[3],
      bicepExercises[4],
      bicepExercises[6],
    ],
  ),
  // beginner workout day 2
  Workout(
    id: 'beginner',
    name: 'Beginner Day 2',
    imagePath: 'assets/exercises/icons/day_2.png',
    exercises: [
      tricepExercises[2],
      tricepExercises[3],
      tricepExercises[5],
      tricepExercises[7],
      shoulderExercises[2],
      shoulderExercises[4],
      shoulderExercises[5],
      shoulderExercises[6],
      legExercises[0],
      legExercises[5],
      legExercises[6],
      legExercises[7],
    ],
  ),
];