import 'package:flutter/material.dart';

enum FoodStatus {
  green,
  yellow,
  red;

  Color get color => switch (this) {
        FoodStatus.green => const Color(0xFF4ADE80),
        FoodStatus.yellow => const Color(0xFFFBBF24),
        FoodStatus.red => const Color(0xFFF87171),
      };

  Color get darkColor => switch (this) {
        FoodStatus.green => const Color(0xFF166534),
        FoodStatus.yellow => const Color(0xFF92400E),
        FoodStatus.red => const Color(0xFF7F1D1D),
      };

  static FoodStatus fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'green' => FoodStatus.green,
      'yellow' => FoodStatus.yellow,
      'red' => FoodStatus.red,
      _ => FoodStatus.yellow,
    };
  }
}
