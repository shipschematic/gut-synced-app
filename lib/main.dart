import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gutsynced/helpers/services/storage/local_storage.dart';
import 'package:gutsynced/helpers/services/supabase_service.dart';
import 'package:gutsynced/helpers/services/app_config.dart';
import 'package:gutsynced/helpers/theme/app_theme.dart';
import 'package:gutsynced/helpers/theme/theme_customizer.dart';
import 'package:gutsynced/route/route_method.dart';
import 'package:gutsynced/route/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  await AppConfig().load();
  await SupabaseService().init();
  runApp(const GutSyncedApp());
}

class GutSyncedApp extends StatelessWidget {
  const GutSyncedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GutSynced',
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
