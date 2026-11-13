import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:gutsynced/app/controller/food_controller.dart';
import 'package:gutsynced/app/model/food_status.dart';
import 'package:gutsynced/helpers/services/translations_service.dart';

class DetailScreen extends StatelessWidget {
  final String foodName;

  const DetailScreen({super.key, required this.foodName});

  @override
  Widget build(BuildContext context) {
    final foodC = Get.find<FoodController>();
    final t = TranslationsService();
    final item = foodC.findFoodByName(foodName);

    if (item == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Not Found')),
        body: const Center(child: Text('Food item not found')),
      );
    }

    final translatedName = t.translateFood(item.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translatedName.length > 25 ? '${translatedName.substring(0, 25)}...' : translatedName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.status.color.withValues(alpha: 0.15),
                  border: Border.all(color: item.status.color.withValues(alpha: 0.3), width: 3),
                ),
                child: Center(
                  child: Text(
                    item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: item.status.color),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(translatedName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            if (translatedName != item.name)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: Text(item.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300,
                      color: Colors.grey, fontStyle: FontStyle.italic)),
                ),
              ),
            const SizedBox(height: 32),
            _buildInfoRow(LucideIcons.tags, 'Category', t.translateCategory(item.category), null),
            const SizedBox(height: 16),
            _buildInfoRow(LucideIcons.circle, 'Status', _statusLabel(item, t), item.status.color),
            if (item.sidenote != null && item.sidenote!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildSidenote(item.sidenote!, t),
            ],
            const SizedBox(height: 32),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAction(
                    icon: LucideIcons.copy,
                    label: 'Copy Name',
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: translatedName));
                    },
                    color: const Color(0xFF6750A4),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => foodC.toggleFavorite(item),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: item.isFavorite
                            ? Colors.red.withValues(alpha: 0.15)
                            : const Color(0xFF3A3A3C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        LucideIcons.heart,
                        color: item.isFavorite ? Colors.redAccent : Colors.grey,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color? color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color ?? const Color(0xFF6750A4), size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color ?? Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSidenote(String text, TranslationsService t) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFC107).withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.info, color: Color(0xFFFFC107), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.translate('sidenote_label'),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFFFC107))),
                const SizedBox(height: 4),
                Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction({required IconData icon, required String label, required VoidCallback onTap, required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color)),
          ],
        ),
      ),
    );
  }

  String _statusLabel(dynamic item, TranslationsService t) {
    switch (item.status) {
      case FoodStatus.green: return t.translate('color_green');
      case FoodStatus.yellow: return t.translate('color_yellow');
      case FoodStatus.red: return t.translate('color_red');
      default: return t.translate('color_green');
    }
  }
}
