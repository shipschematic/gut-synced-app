import 'package:get/get.dart';
import 'package:gut_sync/app/data/food_repository.dart';
import 'package:gut_sync/app/model/food_category.dart';
import 'package:gut_sync/app/model/food_item.dart';
import 'package:gut_sync/app/model/food_status.dart';
import 'package:gut_sync/app/model/diet_profile.dart';
import 'package:gut_sync/helpers/services/supabase_service.dart';

class FoodController extends GetxController {
  final FoodRepository _repository = FoodRepository();

  final RxBool isLoaded = false.obs;
  final RxString searchQuery = ''.obs;
  final Rx<FoodStatus?> statusFilter = Rx<FoodStatus?>(null);
  final RxBool favoritesOnly = false.obs;
  final Rx<DietProfile> activeDiet = siboProfile.obs;
  final RxString currentLanguage = 'en'.obs;
  final RxInt refreshKey = 0.obs;

  List<DietProfile> get availableDiets => [
        siboProfile,
        ssrdProfile,
        bileRefluxProfile,
        sixFedlrProfile,
      ];

  List<FoodCategory> get filteredCategories =>
      _repository.filterCategories(
        searchQuery: searchQuery.value,
        statusFilter: statusFilter.value,
        favoritesOnly: favoritesOnly.value,
      );

  bool get hasFavorites => _repository.hasFavorites();
  int get favoriteCount => _repository.favoriteCount;
  List<FoodItem> get allItems => _repository.allItems;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    await _repository.loadDataForDiet(activeDiet.value);
    _restoreCloudFavorites();
    isLoaded.value = true;
  }

  Future<void> switchDiet(DietProfile diet) async {
    if (diet.id == activeDiet.value.id) return;
    activeDiet.value = diet;
    isLoaded.value = false;
    await _repository.loadDataForDiet(diet);
    isLoaded.value = true;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  void setStatusFilter(FoodStatus? status) {
    statusFilter.value = status;
  }

  void clearStatusFilter() {
    statusFilter.value = null;
  }

  Future<void> toggleFavorite(FoodItem item) async {
    await _repository.toggleFavorite(item);
    refreshKey.value++;
    _syncFavorites();
  }

  Future<void> clearAllFavorites() async {
    await _repository.clearAllFavorites();
    refreshKey.value++;
    _syncFavorites();
  }

  void setLanguage(String lang) {
    currentLanguage.value = lang;
  }

  FoodItem? findFoodByName(String name) => _repository.findByName(name);

  Future<void> _syncFavorites() async {
    final names = _repository.allItems
        .where((i) => i.isFavorite)
        .map((i) => i.name)
        .toSet();
    await SupabaseService().syncFavorites(names);
  }

  Future<void> _restoreCloudFavorites() async {
    final cloudFavs = await SupabaseService().loadFavorites();
    if (cloudFavs.isEmpty) return;
    for (final item in _repository.allItems) {
      if (cloudFavs.contains(item.name)) {
        item.isFavorite = true;
      }
    }
  }
}
