import 'package:skbwmember/features/exercises/domain/entities/workout.dart';

class Routine {
  final String id;
  final String name;
  final List<Workout> workouts;

  Routine({
    required this.id,
    required this.name,
    required this.workouts,
  });
}
