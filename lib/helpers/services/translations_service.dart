import 'package:get/get.dart';
import 'package:gut_sync/app/controller/food_controller.dart';

class TranslationsService extends GetxService {
  final Map<String, Map<String, dynamic>> _translations = {
    "en": {
      "ready": "Ready",
      "search_foods": "Search foods...",
      "clear_favorites": "Clear Favorites",
      "favorites": "Favorites",
      "no_results": "No foods found matching your search criteria.",
      "sibo_helper": "SiboHelper",
      "diet_guide": "SIBO specific diet food guide",
      "removed_favorite": "Removed {} from favorites",
      "added_favorite": "Added {} to favorites",
      "all_cleared": "All favorites cleared",
      "show_guide": "Show Guide",
      "sibo_diet_guide": "SIBO Diet Guidelines",
      "text_copied": "Text copied to clipboard",
      "copy_translated": "Copy translated name",
      "copy_original": "Copy original name",
      "color_green": "Green",
      "color_yellow": "Yellow",
      "color_red": "Red",
      "comprehensive_note":
          "SiboHelper\nSIBO specific diet food guide. For people with diagnosed SIBO (small intestinal bacterial overgrowth) condition.\nDisclaimer: This app is provided for educational purposes only; please ensure you seek the advice of a qualified doctor before making changes to your diet.\nRed: avoid. Green: allowed (low Fodmap). Yellow: allowed in small amounts (moderate & high Fodmap).\nT= tablespoon, t= teaspoon, g = gram, ea = each, oz = ounce, C= cup\nSome foods have sidenotes about how much of the food is allowed. If there is no sidenote next to foods marked with yellow, consume according to your tolerance. Start the diet with low Fodmap foods (green). Where there are two allowed amounts stated,for example 1-2 c, the first amount is lower in Fodmap, and the second is higher in Fodmap. Stick to lower Fodmap in the beginning. Wait 1-3 months to introduce celery root, rutabagas, cruciferous vegetables, beans, seeds, nuts (including nut flours, butters & milks) coffee, alcohol, raw vegetables/salads and raw fruit. Cook, peel, de-seed and puree vegetables & fruit at first. Dairy is best avoided for the first few weeks if unsure of its tolerability.\nModerate & high Fodmap foods (yellow): limit to 1 per meal. Meal = eating separated by 3-4 hours. Quantity listings are adult portions: decrease amounts for children.\nTailor the diet: individual variations from this list are to be expected - trust your body's reactions over the list.\nTolerances change over time: periodically re-try previously intolerant foods.",
      "showing_items": "Showing {} items",
      "all_food": "All-Food",
      "status_well_tolerated": "Well tolerated",
      "status_tolerated_by_some": "Tolerated by some",
      "status_not_tolerated": "Not tolerated",
      "sidenote_label": "Note",
      "comprehensive_note_ssrd":
          "SSRD Diet\nStarch- and sucrose-reduced diet recommendations for fruits and vegetables.\nDisclaimer: This app is provided for educational purposes only; please ensure you seek the advice of a qualified doctor before making changes to your diet.\nGreen: well tolerated. Yellow: tolerated by some (introduce with caution). Red: not tolerated.\nFoods marked with an asterisk (*) may cause bloating/flatulence in all individuals when consumed in excess — moderation is advised.\nTailor the diet: individual variations from this list are to be expected - trust your body's reactions over the list.\nTolerances change over time: periodically re-try previously intolerant foods.",
      "status_allowed": "Allowed",
      "status_caution_strict_prep": "Caution (strict prep/labels)",
      "status_avoid": "Avoid",
      "comprehensive_note_6fedlr":
          "6-Food Elimination & Low-Residue Diet\nModified elimination diet for eosinophilic esophagitis (EoE) and GI healing.\nDisclaimer: This app is provided for educational purposes only; please ensure you seek the advice of a qualified doctor before making changes to your diet.\nGreen: Allowed (safe foods). Yellow: Caution (must follow strict preparation or read labels carefully). Red: Avoid (trigger foods).\nSix major allergens eliminated: dairy, eggs, soy, wheat/gluten, nuts, and seafood/fish.\nAdditional low-residue restrictions: no raw vegetables, no leafy greens, no high-fiber grains.\nPreparation is critical: peel all fruits/vegetables, cook until soft/mashable, read all ingredient labels.\nTailor the diet: individual variations from this list are to be expected - trust your body's reactions over the list.\nTolerances change over time: periodically re-try previously intolerant foods.",
      "comprehensive_note_bile":
          "Bile Reflux Diet\nLow-fat, low-acid dietary recommendations for managing bile reflux.\nDisclaimer: This app is provided for educational purposes only; please ensure you seek the advice of a qualified doctor before making changes to your diet.\nGreen: typically well tolerated. Yellow: tolerated by some (introduce with caution). Red: typically not tolerated.\nKey principles: eat small, frequent meals; avoid lying down after eating; limit high-fat and fried foods; reduce acidic and spicy foods.\nTailor the diet: individual variations from this list are to be expected - trust your body's reactions over the list.\nTolerances change over time: periodically re-try previously intolerant foods.",
      "diet_name_sibo": "SIBO",
      "diet_name_ssrd": "SSRD",
      "diet_name_bile": "Bile Reflux",
      "diet_name_6fedlr": "6-FED Low Residue",
      "diet_desc_sibo": "SIBO specific diet food guide",
      "diet_desc_ssrd": "Starch & sucrose reduced diet",
      "diet_desc_bile": "Low-fat diet for bile reflux",
      "diet_desc_6fedlr": "6-food elimination & low residue",
    },
    "zh": {
      "ready": "准备就绪",
      "search_foods": "搜索食物...",
      "clear_favorites": "清除收藏",
      "favorites": "收藏夹",
      "no_results": "未找到符合搜索条件的食物。",
      "sibo_helper": "Sibo助手",
      "diet_guide": "SIBO特定饮食食物指南",
      "removed_favorite": "已从收藏中移除 {}",
      "added_favorite": "已添加到收藏 {}",
      "all_cleared": "所有收藏已清除",
      "show_guide": "显示指南",
      "sibo_diet_guide": "SIBO饮食指南",
      "text_copied": "文本已复制到剪贴板",
      "copy_translated": "复制翻译名称",
      "copy_original": "复制原始名称",
      "color_green": "绿色",
      "color_yellow": "黄色",
      "color_red": "红色",
      "comprehensive_note":
          "Sibo助手\nSIBO特定饮食食物指南。适用于确诊为SIBO（小肠细菌过度生长）的人群。\n免责声明：本应用仅供教育目的；请在更改饮食前咨询合格医生。\n红色：避免。绿色：允许（低Fodmap）。黄色：少量允许（中高Fodmap）。\nT=汤匙，t=茶匙，g=克，ea=每个，oz=盎司，C=杯\n某些食物有关于允许食用量的旁注。如果黄色标记的食物旁边没有旁注，请根据您的耐受度食用。从低Fodmap食物（绿色）开始饮食。如果列出了两个允许量，例如1-2杯，第一个量是较低Fodmap，第二个是较高Fodmap。开始时坚持较低Fodmap。等待1-3个月再引入芹菜根、芜菁甘蓝、十字花科蔬菜、豆类、种子、坚果（包括坚果粉、黄油和牛奶）、咖啡、酒精、生蔬菜/沙拉和生水果。开始时烹饪、去皮、去籽并打成泥蔬菜和水果。如果不确定乳制品的耐受性，最好在最初几周避免食用。\n中高Fodmap食物（黄色）：每餐限制为1种。餐=相隔3-4小时的进食。数量列表为成人份量：儿童应减少份量。\n个性化饮食：预计会有个体差异 - 相信您身体的反应胜过列表。\n耐受度随时间变化：定期重新尝试之前不耐受的食物。",
      "showing_items": "显示 {} 个项目",
      "all_food": "全部食物",
      "status_well_tolerated": "耐受良好",
      "status_tolerated_by_some": "部分人可耐受",
      "status_not_tolerated": "不耐受",
      "sidenote_label": "备注",
      "comprehensive_note_ssrd":
          "SSRD饮食\n针对水果和蔬菜的淀粉和蔗糖减少饮食建议。\n免责声明：本应用仅供教育目的；请在更改饮食前咨询合格医生。\n绿色：耐受良好。黄色：部分人可耐受（谨慎引入）。红色：不耐受。\n标有星号 (*) 的食物在过量摄入时可能会在所有人群中引起腹胀/排气 — 建议适量食用。\n个性化饮食：预计会有个体差异 - 相信您身体的反应胜过列表。\n耐受度随时间变化：定期重新尝试之前不耐受的食物。",
      "status_allowed": "允许",
      "status_caution_strict_prep": "注意（严格准备/标签）",
      "status_avoid": "避免",
      "comprehensive_note_6fedlr":
          "6种食物消除与低渣饮食\n针对嗜酸性食管炎(EoE)和胃肠道愈合的改良消除饮食。\n免责声明：本应用仅供教育目的；请在更改饮食前咨询合格医生。\n绿色：允许（安全食物）。黄色：注意（必须严格准备或仔细阅读标签）。红色：避免（触发食物）。\n消除六大过敏原：乳制品、鸡蛋、大豆、小麦/麸质、坚果、海鲜/鱼类。\n额外低渣限制：无生蔬菜、无绿叶蔬菜、无高纤维谷物。\n准备至关重要：所有水果/蔬菜去皮，烹饪至软/可捣碎状态，阅读所有成分标签。\n个性化饮食：预计会有个体差异 - 相信您身体的反应胜过列表。\n耐受度随时间变化：定期重新尝试之前不耐受的食物。",
      "comprehensive_note_bile":
          "胆汁反流饮食\n针对胆汁反流的低脂、低酸饮食建议。\n免责声明：本应用仅供教育目的；请在更改饮食前咨询合格医生。\n绿色：通常耐受良好。黄色：部分人可耐受（谨慎引入）。红色：通常不耐受。\n关键原则：少食多餐；饭后避免躺下；限制高脂肪和油炸食物；减少酸性和辛辣食物。\n个性化饮食：预计会有个体差异 - 相信您身体的反应胜过列表。\n耐受度随时间变化：定期重新尝试之前不耐受的食物。",
      "diet_name_sibo": "SIBO",
      "diet_name_ssrd": "SSRD",
      "diet_name_bile": "胆汁反流",
      "diet_name_6fedlr": "6-FED 低渣",
      "diet_desc_sibo": "SIBO特定饮食食物指南",
      "diet_desc_ssrd": "淀粉/蔗糖减少饮食",
      "diet_desc_bile": "胆汁反流低脂饮食",
      "diet_desc_6fedlr": "6食物消除/低渣饮食",
    },
  };

  final Map<String, Map<String, String>> _categoryTranslations = {
    "en": {
      "Cereals": "Cereals",
      "Dairy": "Dairy",
      "Drinks": "Drinks",
      "Fats/Oils": "Fats/Oils",
      "Fruits": "Fruits",
      "Legumes": "Legumes",
      "Meats": "Meats",
      "Nuts/Seeds": "Nuts/Seeds",
      "Seasonings/Condiments": "Seasonings/Condiments",
      "Sweeteners": "Sweeteners",
      "Veggies": "Veggies",
    },
    "zh": {
      "Cereals": "谷物",
      "Dairy": "乳制品",
      "Drinks": "饮料",
      "Fats/Oils": "脂肪/油",
      "Fats & Oils": "脂肪和油",
      "Fruits": "水果",
      "Legumes": "豆类",
      "Meats": "肉类",
      "Nuts/Seeds": "坚果/种子",
      "Seasonings/Condiments": "调味品/佐料",
      "Sweeteners": "甜味剂",
      "Veggies": "蔬菜",
      "Proteins": "蛋白质",
      "Grains & Starches": "谷物和淀粉",
      "Vegetables": "蔬菜",
      "Dairy & Milk Alternatives": "乳制品和奶替代品",
      "Beverages": "饮品",
      "Sweeteners & Flavor Additions": "甜味剂和调味品",
      "Nuts & Seeds": "坚果和籽类",
      "Flavorings & Sweeteners": "调味品和甜味剂",
      "Fats": "脂肪",
    },
  };

  String get _currentLang =>
      Get.find<FoodController>().currentLanguage.value;

  String translate(String key, [List<dynamic> args = const []]) {
    final text = _translations[_currentLang]?[key];
    if (text == null) return key;
    String result = text.toString();
    for (int i = 0; i < args.length; i++) {
      result = result.replaceFirst('{}', args[i].toString());
    }
    return result;
  }

  String translateCategory(String name) {
    return _categoryTranslations[_currentLang]?[name] ?? name;
  }

  String translateFood(String name) {
    final foodMap = _translations[_currentLang];
    if (foodMap == null) return name;
    final val = foodMap[name];
    if (val is String && val.isNotEmpty) return val;
    return name;
  }
}
