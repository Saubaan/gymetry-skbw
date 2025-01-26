import 'package:flutter/material.dart';
import 'package:skbwmember/features/diet/domain/entities/diet.dart';
import 'package:skbwmember/features/diet/presentation/components/time_slot_card.dart';
import 'package:skbwmember/theme/app_font.dart';

class DietPage extends StatelessWidget {
  final Diet diet;

  const DietPage({super.key, required this.diet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.secondary,
        foregroundColor: theme.onSecondary,
        centerTitle: true,
        title: Text(
          '${diet.name} Diet',
          style: TextStyle(
            fontSize: 18,
            fontFamily: AppFont.primaryFont,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: diet.timeSlots.length,
        itemBuilder: (context, index) {
          final timeSlot = diet.timeSlots[index];
          return TimeSlotCard(timeSlot: timeSlot);
        },
      ),
    );
  }
}
