import 'package:skbwmember/features/diet/domain/entities/time_slot.dart';

class Diet {
  final String name;
  final List<TimeSlot> timeSlots;

  Diet({
    required this.name,
    required this.timeSlots,
  });
}