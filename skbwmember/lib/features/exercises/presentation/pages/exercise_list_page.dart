import 'package:flutter/material.dart';
import 'package:skbwmember/components/title_card.dart';
import 'package:skbwmember/features/exercises/data/back_exercise_data.dart';
import 'package:skbwmember/features/exercises/presentation/pages/exercise_page.dart';
import 'package:skbwmember/theme/app_font.dart';

class ExerciseListPage extends StatelessWidget {
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            TitleCard(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Exercises',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppFont.primaryFont,
                      color: theme.onSecondary,
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.secondary,
                borderRadius: BorderRadius.circular(sWidth / 30),
              ),
              height: sHeight,
              child: ListView.builder(
                itemCount: backExercises.length,
                itemBuilder: (context, index) {
                  final exercise = backExercises[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ExercisePage(exercise: exercise),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
