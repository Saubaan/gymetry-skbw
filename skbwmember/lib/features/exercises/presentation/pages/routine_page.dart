import 'package:flutter/material.dart';
import 'package:skbwmember/features/exercises/domain/entities/workout.dart';
import 'package:skbwmember/features/exercises/presentation/pages/workout_page.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/navigation.dart';

class RoutinePage extends StatelessWidget {
  final List<Workout> workouts;

  const RoutinePage({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondary,
        foregroundColor: theme.onSecondary,
        centerTitle: true,
        title: Text(
          'Workout Routines',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFont.primaryFont,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: theme.secondary,
                foregroundColor: theme.onSecondary,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                pushPage(context, WorkoutPage(workout: workouts[index]), 1);
              },
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: theme.secondary,
                leading: Image.asset(
                  workouts[index].imagePath,
                  width: sHeight / 10,
                ),
                title: Text(
                  workouts[index].name,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFont.logoFont,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
