import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gutsynced/app/model/food_category.dart';
import 'package:gutsynced/app/model/food_item.dart';
import 'package:gutsynced/app/model/food_status.dart';
import 'package:gutsynced/app/model/diet_profile.dart';

class FoodRepository {
  List<FoodCategory> _categories = [];
  bool _isLoaded = false;
  String _currentDiet = 'sibo';

  List<FoodCategory> get categories => _categories;
  bool get isLoaded => _isLoaded;
  String get currentDiet => _currentDiet;

  List<FoodItem> get allItems => _categories.expand((c) => c.items).toList();

  int get favoriteCount => allItems.where((i) => i.isFavorite).length;

  bool hasFavorites() => allItems.any((i) => i.isFavorite);

  Future<void> loadDataForDiet(DietProfile diet, {bool forceReload = false}) async {
    if (diet.id == _currentDiet && _isLoaded && !forceReload) return;
    _currentDiet = diet.id;
    await _loadFromAsset(diet.assetPath);
    await _restoreFavorites();
    _isLoaded = true;
  }

  Future<void> _loadFromAsset(String assetPath) async {
    try {
      final String jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> json = jsonDecode(jsonString) as Map<String, dynamic>;
      final List<dynamic> categoriesJson = json['categories'] as List<dynamic>;
      _categories = categoriesJson
          .map((e) => FoodCategory.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _categories = [];
    }
  }

  Future<void> _restoreFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNames = prefs.getStringList('${_currentDiet}_favorites') ?? [];
    final favSet = favoriteNames.toSet();
    for (final item in allItems) {
      if (favSet.contains(item.name)) {
        item.isFavorite = true;
      }
    }
  }

  Future<void> toggleFavorite(FoodItem item) async {
    item.isFavorite = !item.isFavorite;
    await _saveFavorites();
  }

  Future<void> clearAllFavorites() async {
    for (final item in allItems) {
      item.isFavorite = false;
    }
    await _saveFavorites();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = allItems.where((i) => i.isFavorite).map((i) => i.name).toList();
    await prefs.setStringList('${_currentDiet}_favorites', favorites);
  }

  List<FoodCategory> filterCategories({
    String searchQuery = '',
    FoodStatus? statusFilter,
    bool favoritesOnly = false,
  }) {
    List<FoodCategory> result = [];

    for (final category in _categories) {
      List<FoodItem> filtered = category.items.toList();

      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filtered = filtered.where((item) => item.name.toLowerCase().contains(query)).toList();
      }

      if (statusFilter != null) {
        filtered = filtered.where((item) => item.status == statusFilter).toList();
      }

      if (favoritesOnly) {
        filtered = filtered.where((item) => item.isFavorite).toList();
      }

      if (filtered.isNotEmpty) {
        result.add(FoodCategory(
          name: category.name,
          items: filtered,
          isExpanded: category.isExpanded,
        ));
      }
    }

    return result;
  }

  FoodItem? findByName(String name) {
    try {
      return allItems.firstWhere((item) => item.name == name);
    } catch (_) {
      return null;
    }
  }
}
