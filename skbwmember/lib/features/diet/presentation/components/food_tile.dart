import 'package:flutter/material.dart';
import 'package:skbwmember/features/diet/domain/entities/food.dart';
import 'package:skbwmember/theme/app_font.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  const FoodTile({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final sWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              food.imagePath,
              width: sWidth /8,
              height: sWidth /8,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: AppFont.logoFont,
                    color: theme.onSecondary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  food.quantity,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.onSecondary.withAlpha(100),
                    fontFamily: AppFont.primaryFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
