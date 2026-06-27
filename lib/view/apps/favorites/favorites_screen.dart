import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:gut_sync/app/controller/food_controller.dart';
import 'package:gut_sync/app/model/food_item.dart';
import 'package:gut_sync/helpers/services/translations_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodC = Get.find<FoodController>();
    final t = TranslationsService();

    return Obx(() {
      final favs = foodC.allItems.where((i) => i.isFavorite).toList();

      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(LucideIcons.heart, color: Colors.redAccent, size: 20),
              const SizedBox(width: 8),
              Text('Favorites (${favs.length})'),
            ],
          ),
          actions: [
            if (favs.isNotEmpty)
              IconButton(
                icon: const Icon(LucideIcons.trash_2, color: Colors.red),
                onPressed: () {
                  foodC.clearAllFavorites();
                },
              ),
          ],
        ),
        body: favs.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.heart, color: Color(0xFF3A3A3C), size: 64),
                    const SizedBox(height: 16),
                    const Text('No favorites yet',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey)),
                    const SizedBox(height: 8),
                    const Text('Tap the heart icon to save foods',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey)),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favs.length,
                itemBuilder: (_, i) => _buildFoodItem(favs[i], foodC, t),
              ),
      );
    });
  }

  Widget _buildFoodItem(FoodItem item, FoodController foodC, TranslationsService t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: () => Get.toNamed('/food/${Uri.encodeComponent(item.name)}'),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: item.status.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Icon(LucideIcons.circle, color: item.status.color, size: 20)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.translateFood(item.name),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(t.translateCategory(item.category),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.heart, color: Colors.redAccent, size: 22),
                  onPressed: () => foodC.toggleFavorite(item),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
