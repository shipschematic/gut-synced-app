import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:gut_sync/app/controller/food_controller.dart';
import 'package:gut_sync/app/controller/auth_controller.dart';
import 'package:gut_sync/app/model/food_category.dart';
import 'package:gut_sync/app/model/food_item.dart';
import 'package:gut_sync/app/model/food_status.dart';
import 'package:gut_sync/helpers/services/translations_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodC = Get.find<FoodController>();
    final authC = Get.find<AuthController>();
    final t = TranslationsService();

    return Obx(() {
      if (!foodC.isLoaded.value) {
        return Scaffold(
          appBar: _buildAppBar(context, foodC, authC, t),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      foodC.refreshKey.value;
      final categories = foodC.filteredCategories;

      return Scaffold(
        appBar: _buildAppBar(context, foodC, authC, t),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _buildSearchField(foodC, t),
            ),
            _buildFavoritesRow(foodC, t),
            _buildStatusFilter(foodC, t),
            Expanded(
              child: categories.isEmpty
                  ? _buildEmptyState(t)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (_, i) => _buildCategoryCard(categories[i], foodC, t),
                    ),
            ),
          ],
        ),
      );
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, FoodController foodC, AuthController authC, TranslationsService t) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6750A4), Color(0xFF9C82C4)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(LucideIcons.utensils_crossed, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          const Text('GutSync'),
        ],
      ),
      actions: [
        _buildDietSwitcher(foodC, t),
        _buildLanguageSelector(foodC, t),
      ],
    );
  }

  Widget _buildDietSwitcher(FoodController foodC, TranslationsService t) {
    return Obx(() {
      final active = foodC.activeDiet.value;
      return PopupMenuButton<String>(
        offset: const Offset(0, 4),
        onSelected: (dietId) {
          final diet = foodC.availableDiets.firstWhere((d) => d.id == dietId);
          foodC.switchDiet(diet);
        },
        itemBuilder: (_) => foodC.availableDiets.map((diet) {
          final isActive = diet.id == active.id;
          return PopupMenuItem<String>(
            value: diet.id,
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF6750A4).withValues(alpha: 0.15) : const Color(0xFF3A3A3C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(LucideIcons.utensils, color: isActive ? const Color(0xFF6750A4) : Colors.grey, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(diet.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: isActive ? const Color(0xFF6750A4) : Colors.white)),
                      Text(diet.description, style: TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                if (isActive) const Icon(LucideIcons.circle_check, color: Color(0xFF6750A4), size: 18),
              ],
            ),
          );
        }).toList(),
        child: Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF3A3A3C),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF6750A4).withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(LucideIcons.utensils, color: const Color(0xFF6750A4), size: 14),
              const SizedBox(width: 4),
              Text(active.shortName, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF6750A4))),
              const SizedBox(width: 2),
              Icon(LucideIcons.chevron_down, color: const Color(0xFF6750A4), size: 14),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLanguageSelector(FoodController foodC, TranslationsService t) {
    return Obx(() {
      final lang = foodC.currentLanguage.value;
      return Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: lang,
            isDense: true,
            dropdownColor: const Color(0xFF2C2C2E),
            icon: const Icon(LucideIcons.languages, color: Colors.grey, size: 16),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
            onChanged: (v) {
              if (v != null) foodC.setLanguage(v);
            },
            items: const [
              DropdownMenuItem(value: 'en', child: Text('EN')),
              DropdownMenuItem(value: 'zh', child: Text('中文')),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSearchField(FoodController foodC, TranslationsService t) {
    return Obx(() {
      final query = foodC.searchQuery.value;
      return TextField(
        onChanged: (v) => foodC.setSearchQuery(v),
        controller: TextEditingController.fromValue(TextEditingValue(text: query)),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: t.translate('search_foods'),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(LucideIcons.search, color: Colors.grey, size: 20),
          ),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: Icon(LucideIcons.x, color: Colors.grey, size: 18),
                  onPressed: () => foodC.clearSearch(),
                )
              : null,
        ),
      );
    });
  }

  Widget _buildFavoritesRow(FoodController foodC, TranslationsService t) {
    return Obx(() {
      foodC.refreshKey.value;
      final favOnly = foodC.favoritesOnly.value;
      final hasFavs = foodC.hasFavorites;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(LucideIcons.heart, color: Colors.redAccent, size: 18),
                const SizedBox(width: 8),
                Text(t.translate('favorites'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const Spacer(),
                Switch(
                  value: favOnly,
                  onChanged: (v) => foodC.favoritesOnly.value = v,
                  activeTrackColor: const Color(0xFF6750A4).withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
          if (hasFavs && favOnly)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => foodC.clearAllFavorites(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(LucideIcons.trash_2, color: Colors.red, size: 14),
                          const SizedBox(width: 4),
                          Text(t.translate('clear_favorites'), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.red)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildStatusFilter(FoodController foodC, TranslationsService t) {
    final statuses = [
      (null, t.translate('all_food'), LucideIcons.circle_check, const Color(0xFF6750A4)),
      (FoodStatus.green, t.translate('color_green'), LucideIcons.leaf, const Color(0xFF4CAF50)),
      (FoodStatus.yellow, t.translate('color_yellow'), LucideIcons.triangle_alert, const Color(0xFFFFC107)),
      (FoodStatus.red, t.translate('color_red'), LucideIcons.ban, const Color(0xFFF44336)),
    ];

    return Obx(() {
      final activeFilter = foodC.statusFilter.value;
      return SizedBox(
        height: 44,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          children: statuses.map((s) {
            final isActive = activeFilter == s.$1;
            final chipColor = s.$4;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  if (isActive) {
                    foodC.clearStatusFilter();
                  } else {
                    foodC.setStatusFilter(s.$1);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? chipColor.withValues(alpha: 0.15) : const Color(0xFF3A3A3C),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isActive ? chipColor.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.08),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(s.$3, color: isActive ? chipColor : Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text(s.$2, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isActive ? chipColor : Colors.grey)),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildEmptyState(TranslationsService t) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 80, left: 32, right: 32),
        child: Column(
          children: [
            Container(
              width: 72, height: 72,
              decoration: const BoxDecoration(color: Color(0xFF3A3A3C), shape: BoxShape.circle),
              child: const Icon(LucideIcons.search_x, color: Colors.grey, size: 36),
            ),
            const SizedBox(height: 20),
            Text(t.translate('no_results'), textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
            const SizedBox(height: 8),
            const Text('Try adjusting your search or filters', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xFF3A3A3C))),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(FoodCategory category, FoodController foodC, TranslationsService t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          title: Row(
            children: [
              Expanded(
                child: Text(t.translateCategory(category.name),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('${category.items.length}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
              ),
            ],
          ),
          initiallyExpanded: category.isExpanded,
          onExpansionChanged: (expanded) => category.isExpanded = expanded,
          iconColor: Colors.grey,
          collapsedIconColor: Colors.grey,
          collapsedShape: const Border(),
          shape: const Border(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                children: category.items.map((item) => _buildFoodItem(item, foodC, t)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(FoodItem item, FoodController foodC, TranslationsService t) {
    final statusColor = item.status.color;
    final isFav = item.isFavorite;
    final hasSidenote = item.sidenote != null && item.sidenote!.isNotEmpty;

    void showCopyOptions() {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(LucideIcons.copy, color: Color(0xFF6750A4)),
                title: const Text('Copy translated name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                onTap: () {
                  Get.back();
                  Clipboard.setData(ClipboardData(text: t.translateFood(item.name)));
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.copy_check, color: Color(0xFF9C82C4)),
                title: const Text('Copy original name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                onTap: () {
                  Get.back();
                  Clipboard.setData(ClipboardData(text: item.name));
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed('/food/${Uri.encodeComponent(item.name)}'),
          onLongPress: showCopyOptions,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Icon(LucideIcons.circle, color: statusColor, size: 16)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.translateFood(item.name),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      if (hasSidenote) ...[
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(LucideIcons.info, size: 11, color: statusColor.withValues(alpha: 0.7)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(item.sidenote!,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300,
                                  color: Colors.grey, height: 1.3),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => foodC.toggleFavorite(item),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      LucideIcons.heart,
                      color: isFav ? Colors.redAccent : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
