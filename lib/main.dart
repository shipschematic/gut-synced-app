import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gut_sync/helpers/services/storage/local_storage.dart';
import 'package:gut_sync/helpers/services/supabase_service.dart';
import 'package:gut_sync/helpers/services/app_config.dart';
import 'package:gut_sync/helpers/theme/app_theme.dart';
import 'package:gut_sync/helpers/theme/theme_customizer.dart';
import 'package:gut_sync/route/route_method.dart';
import 'package:gut_sync/route/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  await AppConfig().load();
  await SupabaseService().init();
  runApp(const GutSyncApp());
}

class GutSyncApp extends StatelessWidget {
  const GutSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GutSync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeCustomizer.instance.theme,
      initialRoute: route.splash,
      getPages: getPageRoute(),
      defaultTransition: Transition.noTransition,
    );
  }
}
