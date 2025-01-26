import 'package:flutter/material.dart';
import 'package:skbwmember/features/diet/data/diet_data.dart';
import 'package:skbwmember/features/diet/presentation/pages/diet_page.dart';
import 'package:skbwmember/theme/app_font.dart';
import 'package:skbwmember/utils/navigation.dart';

class DietListPage extends StatelessWidget {
  const DietListPage({super.key});

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
          'Diet plans',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFont.primaryFont,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: diets.length,
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
                pushPage(context, DietPage(diet: diets[index]), 1);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    Image.asset(
                      diets[index].imagePath,
                      width: sHeight / 10,
                      height: sHeight / 10,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${diets[index].name} Diet',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFont.logoFont,
                        color: theme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
