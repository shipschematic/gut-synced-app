import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  String supabaseUrl = '';
  String supabaseAnonKey = '';
  String appName = 'GutSynced';

  bool get hasSupabaseConfig => supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  Future<void> load() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/data/env.json');
      final data = json.decode(jsonStr) as Map<String, dynamic>;
      supabaseUrl = data['supabase_url'] as String? ?? '';
      supabaseAnonKey = data['supabase_anon_key'] as String? ?? '';
      appName = data['app_name'] as String? ?? 'GutSynced';
    } catch (e) {
      debugPrint('AppConfig: Failed to load env.json — $e');
    }
  }
}
