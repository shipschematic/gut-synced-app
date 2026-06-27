import 'package:flutter/material.dart';
import 'package:gut_sync/app/model/food_status.dart';

class DietProfile {
  final String id;
  final String name;
  final String shortName;
  final String description;
  final String assetPath;
  final IconData icon;
  final Map<FoodStatus, String> statusDescriptions;

  const DietProfile({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.assetPath,
    required this.icon,
    required this.statusDescriptions,
  });
}

const siboProfile = DietProfile(
  id: 'sibo',
  name: 'SIBO Diet',
  shortName: 'SIBO',
  description: 'Low FODMAP foods for SIBO management',
  assetPath: 'assets/data/food_data.json',
  icon: Icons.eco_rounded,
  statusDescriptions: {
    FoodStatus.green: 'Allowed (low FODMAP)',
    FoodStatus.yellow: 'Allowed in small amounts (moderate & high FODMAP)',
    FoodStatus.red: 'Avoid',
  },
);

const ssrdProfile = DietProfile(
  id: 'ssrd',
  name: 'SSRD Diet',
  shortName: 'SSRD',
  description: 'Starch- and sucrose-reduced diet',
  assetPath: 'assets/data/ssrd_data.json',
  icon: Icons.grain_rounded,
  statusDescriptions: {
    FoodStatus.green: 'Well tolerated',
    FoodStatus.yellow: 'Tolerated by some',
    FoodStatus.red: 'Not tolerated',
  },
);

const bileRefluxProfile = DietProfile(
  id: 'bile_reflux',
  name: 'Bile Reflux Diet',
  shortName: 'Bile',
  description: 'Low-fat, low-acid foods for bile reflux management',
  assetPath: 'assets/data/bile_data.json',
  icon: Icons.water_drop_rounded,
  statusDescriptions: {
    FoodStatus.green: 'Allowed (safe & safest)',
    FoodStatus.yellow: 'Caution (monitor tolerance)',
    FoodStatus.red: 'Avoid',
  },
);

const sixFedlrProfile = DietProfile(
  id: '6fedlr',
  name: '6-Food Elimination & Low-Residue Diet',
  shortName: '6FED-LR',
  description: 'Modified elimination diet for EoE and GI healing',
  assetPath: 'assets/data/6fedlr_data.json',
  icon: Icons.healing_rounded,
  statusDescriptions: {
    FoodStatus.green: 'Allowed',
    FoodStatus.yellow: 'Caution (strict prep/labels)',
    FoodStatus.red: 'Avoid',
  },
);

final List<DietProfile> availableDiets = [
  siboProfile,
  ssrdProfile,
  bileRefluxProfile,
  sixFedlrProfile,
];
