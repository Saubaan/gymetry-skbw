import 'package:skbwmember/features/diet/domain/entities/food.dart';

class TimeSlot {
  final String time;
  final List<Food> foods;

  TimeSlot({
    required this.time,
    required this.foods,
  });
}