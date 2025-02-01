import 'package:flutter/material.dart';
import 'package:skbwmember/features/exercises/domain/entities/workout.dart';
import 'package:skbwmember/features/exercises/presentation/pages/exercise_page.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/navigation.dart';

class WorkoutPage extends StatelessWidget {
  final Workout workout;
  const WorkoutPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondary,
        foregroundColor: theme.onSecondary,
        centerTitle: true,
        title: Text(
          workout.name,
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFont.primaryFont,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: workout.exercises.length,
          itemBuilder: (context, index) {
            final exercise = workout.exercises[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: theme.secondary,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text('${index + 1}', style: TextStyle(fontSize: 20, color: theme.onPrimary, fontFamily: AppFont.logoFont)),
                ),
                title:
                    Text(exercise.name, style: const TextStyle(fontSize: 20, fontFamily: AppFont.logoFont)),
                onTap: () {
                  pushPage(context, ExercisePage(exercise: exercise), 1);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
