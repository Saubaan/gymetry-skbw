import 'package:skbwmember/features/diet/domain/entities/diet.dart';
import 'package:skbwmember/features/diet/domain/entities/food.dart';
import 'package:skbwmember/features/diet/domain/entities/time_slot.dart';

List<Diet> diets = [
  Diet(
    name: "Weight Gain",
    imagePath: "assets/diet/logo/weight_gain.png",
    timeSlots: [
      TimeSlot(
        time: "6:30 AM",
        foods: [
          Food(name: "Tea", quantity: "1 cup", imagePath: "assets/diet/tea.png"),
          Food(name: "Chapati with peanut butter", quantity: "1 chapati, 1 tbsp peanut butter", imagePath: "assets/diet/roti.png"),
        ],
      ),
      TimeSlot(
        time: "10:00 AM",
        foods: [
          Food(name: "Apple", quantity: "1", imagePath: "assets/diet/apple.png"),
          Food(name: "Multivitamin", quantity: "1 tablet", imagePath: "assets/diet/multivitamin.png"),
        ],
      ),
      TimeSlot(
        time: "1:30 PM Lunch",
        foods: [
          Food(name: "Chicken", quantity: "100 g", imagePath: "assets/diet/chicken.png"),
          Food(name: "Paneer", quantity: "70 g", imagePath: "assets/diet/paneer.png"),
          Food(name: "Rice", quantity: "100 g", imagePath: "assets/diet/rice.png"),
          Food(name: "Salad", quantity: "As desired", imagePath: "assets/diet/salad.png"),
        ],
      ),
      TimeSlot(
        time: "4:00 PM",
        foods: [
          Food(name: "Oats", quantity: "50 g", imagePath: "assets/diet/oats.png"),
          Food(name: "Peanut butter", quantity: "1 scoop", imagePath: "assets/diet/peanut_butter.png"),
        ],
      ),
      TimeSlot(
        time: "6:30 PM",
        foods: [
          Food(name: "Protein powder", quantity: "1 scoop", imagePath: "assets/diet/protein_powder.png"),
          Food(name: "Vitamin C tablet", quantity: "1", imagePath: "assets/diet/vitamin_c.png"),
        ],
      ),
      TimeSlot(
        time: "7:30 PM",
        foods: [
          Food(name: "Egg whites", quantity: "6", imagePath: "assets/diet/boiled_eggs.png"),
          Food(name: "Egg yolk (yellow)", quantity: "1", imagePath: "assets/diet/egg.png"),
        ],
      ),
      TimeSlot(
        time: "9:00 PM Dinner",
        foods: [
          Food(name: "Regular meal", quantity: "Moderate portion", imagePath: "assets/diet/regular_meal.png"),
          Food(name: "Fish oil capsule", quantity: "1 capsule", imagePath: "assets/diet/fish_oil.png"),
        ],
      ),
      TimeSlot(
        time: "Before Sleep",
        foods: [
          Food(name: "Almonds", quantity: "4–5", imagePath: "assets/diet/almonds.png"),
          Food(name: "Milk", quantity: "1 glass", imagePath: "assets/diet/milk.png"),
        ],
      ),
    ],
  ),
  Diet(
    name: "Weight Loss",
    imagePath: "assets/diet/logo/weight_loss.png",
    timeSlots: [
      TimeSlot(
        time: "Early Morning",
        foods: [
          Food(name: "Warm water", quantity: "1 glass", imagePath: "assets/diet/warm_water.png"),
          Food(name: "Lemon", quantity: "1", imagePath: "assets/diet/lemon.png"),
          Food(name: "Honey", quantity: "1 tsp", imagePath: "assets/diet/honey.png"),
        ],
      ),
      TimeSlot(
        time: "Before Workout",
        foods: [
          Food(name: "Black coffee", quantity: "1 cup", imagePath: "assets/diet/black_coffee.png"),
        ],
      ),
      TimeSlot(
        time: "During Workout",
        foods: [
          Food(name: "Energy drink", quantity: "As needed", imagePath: "assets/diet/energy_drink.png"),
          Food(name: "Lemon water with sabza seeds", quantity: "As needed", imagePath: "assets/diet/lemon_basil_water.png"),
        ],
      ),
      TimeSlot(
        time: "After Workout",
        foods: [
          Food(name: "Paneer", quantity: "100 g", imagePath: "assets/diet/paneer.png"),
          Food(name: "Boiled eggs", quantity: "4", imagePath: "assets/diet/boiled_eggs.png"),
        ],
      ),
      TimeSlot(
        time: "11:00 AM",
        foods: [
          Food(name: "Fruit juice", quantity: "1 glass (apple/orange)", imagePath: "assets/diet/fruit_juice.png"),
        ],
      ),
      TimeSlot(
        time: "2:00 PM Lunch",
        foods: [
          Food(name: "Bhakri/Roti", quantity: "1–1.5", imagePath: "assets/diet/roti.png"),
          Food(name: "Mixed sprouts curry", quantity: "1 bowl", imagePath: "assets/diet/mixed_sprouts.png"),
          Food(name: "Boiled eggs", quantity: "2", imagePath: "assets/diet/boiled_eggs.png"),
        ],
      ),
      TimeSlot(
        time: "4:00 PM",
        foods: [
          Food(name: "Salad", quantity: "As desired", imagePath: "assets/diet/salad.png"),
        ],
      ),
      TimeSlot(
        time: "5:00 PM",
        foods: [
          Food(name: "Black coffee", quantity: "1 cup", imagePath: "assets/diet/black_coffee.png"),
        ],
      ),
      TimeSlot(
        time: "9:00 PM Dinner",
        foods: [
          Food(name: "Veg soup", quantity: "1 bowl", imagePath: "assets/diet/veg_soup.png"),
          Food(name: "Roti", quantity: "1", imagePath: "assets/diet/roti.png"),
          Food(name: "Green vegetables", quantity: "As desired", imagePath: "assets/diet/green_vegetables.png"),
          Food(name: "Soybean", quantity: "As desired", imagePath: "assets/diet/soybean.png"),
          Food(name: "Buttermilk", quantity: "1 glass", imagePath: "assets/diet/milk.png"),
          Food(name: "Brown rice", quantity: "1 bowl", imagePath: "assets/diet/brown_rice.png"),
        ],
      ),
    ],
  ),
];
