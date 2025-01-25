import 'package:flutter/material.dart';
import 'package:skbwmember/features/diet/domain/entities/time_slot.dart';
import 'package:skbwmember/features/diet/presentation/components/food_tile.dart';
import 'package:skbwmember/theme/app_font.dart';

class TimeSlotCard extends StatelessWidget {
  final TimeSlot timeSlot;
  const TimeSlotCard({super.key, required this.timeSlot});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeSlot.time,
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppFont.primaryFont,
                color: theme.onSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: timeSlot.foods.map((food) => FoodTile(food: food)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
