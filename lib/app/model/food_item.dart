import 'package:gutsynced/app/model/food_status.dart';

class FoodItem {
  final String name;
  final String category;
  final FoodStatus status;
  final String? sidenote;
  bool isFavorite;

  FoodItem({
    required this.name,
    required this.category,
    required this.status,
    this.sidenote,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'category': category,
        'status': status.name,
        'sidenote': sidenote,
        'isFavorite': isFavorite,
      };

  factory FoodItem.fromJson(Map<String, dynamic> json, {String category = ''}) {
    return FoodItem(
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? category,
      status: FoodStatus.fromString(json['status'] as String?),
      sidenote: json['sidenote'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }
}
