import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dio/dio.dart';
import 'package:gutsynced/helpers/services/logger.dart';
import 'package:gutsynced/helpers/services/app_config.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient? _client;
  Dio? _dio;

  SupabaseClient get client {
    if (_client == null) throw StateError('Supabase not initialized.');
    return _client!;
  }

  bool get isInitialized => _client != null;

  Future<void> init() async {
    if (_client != null) return;

    final config = AppConfig();
    if (!config.hasSupabaseConfig) {
      Logger().warning('Supabase not configured — offline mode');
      return;
    }

    try {
      await Supabase.initialize(
        url: config.supabaseUrl,
        publishableKey: config.supabaseAnonKey,
      );
      _client = Supabase.instance.client;
      _dio = Dio(BaseOptions(
        baseUrl: config.supabaseUrl,
        headers: {'apikey': config.supabaseAnonKey},
      ));
      Logger().info('Supabase initialized');
    } catch (e) {
      Logger().error('Supabase init failed', e);
    }
  }

  Future<void> syncFavorites(Set<String> favoriteNames) async {
    if (_client == null) return;
    final user = _client!.auth.currentUser;
    if (user == null) return;
    try {
      await _client!.from('user_favorites').upsert({
        'user_id': user.id,
        'favorite_names': favoriteNames.toList(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      Logger().error('Failed to sync favorites', e);
    }
  }

  Future<Set<String>> loadFavorites() async {
    if (_client == null) return {};
    final user = _client!.auth.currentUser;
    if (user == null) return {};
    try {
      final response = await _client!
          .from('user_favorites')
          .select('favorite_names')
          .eq('user_id', user.id)
          .single();
      final names = List<String>.from(response['favorite_names'] as List);
      return names.toSet();
    } catch (e) {
      Logger().error('Failed to load favorites', e);
      return {};
    }
  }

  void dispose() {
    _client?.dispose();
    _dio?.close();
  }
}
