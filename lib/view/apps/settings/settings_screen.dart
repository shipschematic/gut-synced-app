import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:gut_sync/app/controller/food_controller.dart';
import 'package:gut_sync/app/controller/auth_controller.dart';
import 'package:gut_sync/helpers/services/translations_service.dart';
import 'package:gut_sync/helpers/theme/theme_customizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodC = Get.find<FoodController>();
    final authC = Get.find<AuthController>();
    final t = TranslationsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Account', [
            Obx(() => authC.isAuthenticated
                ? _settingsTile(LucideIcons.user, 'Signed in as', authC.userEmail.value, null)
                : _settingsTile(LucideIcons.log_in, 'Sign in', 'Backup favorites to cloud', () => Get.toNamed('/auth'))),
            Obx(() {
              if (!authC.isAuthenticated) return const SizedBox.shrink();
              return _settingsTile(LucideIcons.log_out, 'Sign Out', null, () async {
                await authC.signOut();
              }, accent: true);
            }),
          ]),
          const SizedBox(height: 16),
          _buildSection('Preferences', [
            _buildDarkModeTile(),
            _buildLanguageTile(foodC, t),
            Obx(() {
              final diet = foodC.activeDiet.value;
              return _settingsTile(LucideIcons.utensils, 'Active Diet', diet.name, null,
                  trailing: Text(diet.shortName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                    color: const Color(0xFF6750A4))));
            }),
          ]),
          const SizedBox(height: 16),
          _buildSection('About', [
            _settingsTile(null, 'Version', '2.0.0', null),
            _settingsTile(null, 'Data Source', 'Local JSON + Cloud Sync', null),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
        ),
        Card(
          margin: EdgeInsets.zero,
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDarkModeTile() {
    return StatefulBuilder(
      builder: (context, setInnerState) {
        final isDark = ThemeCustomizer.instance.theme == ThemeMode.dark;
        return _settingsTile(
          LucideIcons.moon,
          'Dark Mode',
          null,
          null,
          trailing: Switch(
            value: isDark,
            onChanged: (v) {
              ThemeCustomizer.setTheme(v ? ThemeMode.dark : ThemeMode.light);
              setInnerState(() {});
            },
            activeTrackColor: const Color(0xFF6750A4).withValues(alpha: 0.4),
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile(FoodController foodC, TranslationsService t) {
    return Obx(() {
      final lang = foodC.currentLanguage.value;
      return _settingsTile(
        LucideIcons.languages,
        'Language / 语言',
        lang == 'en' ? 'English' : '中文',
        null,
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: lang,
            isDense: true,
            dropdownColor: const Color(0xFF2C2C2E),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            onChanged: (v) {
              if (v != null) foodC.setLanguage(v);
            },
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'zh', child: Text('中文')),
            ],
          ),
        ),
      );
    });
  }

  Widget _settingsTile(IconData? icon, String title, String? subtitle, VoidCallback? onTap, {
    Widget? trailing, bool accent = false,
  }) {
    return Column(
      children: [
        ListTile(
          leading: icon != null
              ? Icon(icon, color: accent ? Colors.red : const Color(0xFF6750A4), size: 22)
              : null,
          title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
            color: accent ? Colors.red : Colors.white)),
          subtitle: subtitle != null
              ? Text(subtitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey))
              : null,
          trailing: trailing,
          onTap: onTap,
        ),
        Divider(height: 1, color: const Color(0xFF3A3A3C), indent: 16, endIndent: 16),
      ],
    );
  }
}
