import 'package:gutsynced/app/model/food_item.dart';

class FoodCategory {
  final String name;
  final List<FoodItem> items;
  bool isExpanded;

  FoodCategory({
    required this.name,
    required this.items,
    this.isExpanded = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'items': items.map((e) => e.toJson()).toList(),
      };

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>?)
            ?.map((e) => FoodItem.fromJson(e as Map<String, dynamic>,
                category: json['name'] as String? ?? ''))
            .toList() ??
        [];
    return FoodCategory(
      name: json['name'] as String? ?? '',
      items: items,
    );
  }

  int get totalItems => items.length;
}
