# GutSync — SIBO & Gut Health Food Assistant

[![GitHub](https://img.shields.io/badge/GitHub-shipblueprint%2Fgut--sync-blue)](https://github.com/shipblueprint/gut-sync)

A **Flutter** cross-platform application that helps people manage gut health conditions — **SIBO** (Small Intestinal Bacterial Overgrowth), **SSRD** (Starch- and Sucrose-Reduced Diet), **Bile Reflux**, and **6-Food Elimination / Low-Residue Diet** — by providing a comprehensive food database categorized as **allowed (green)**, **caution (yellow)**, or **avoid (red)** for each diet.

---

## Features

- 🥗 **Multi-Diet Support** — Switch between four diet profiles:
  - **SIBO Diet** — Low FODMAP foods for SIBO management
  - **SSRD Diet** — Starch- and sucrose-reduced diet
  - **Bile Reflux Diet** — Low-fat, low-acid foods
  - **6FED-LR Diet** — Six-food elimination & low-residue diet for EoE and GI healing
- 🔍 **Food Lookup** — Browse or search hundreds of foods categorized by name and diet compatibility.
- ⚖️ **Three-Way Status** — Each food is tagged with a traffic-light system:
  - 🟢 **Green** — Allowed / Well tolerated
  - 🟡 **Yellow** — Caution / Limited amounts
  - 🔴 **Red** — Avoid / Not tolerated
- ⭐ **Favorites** — Save frequently used foods for quick access.
- 🌐 **Multi-Language** — Supports English, Arabic, Spanish, French, and Hindi.
- 🌗 **Dark & Light Themes** — Follows system theme or manual toggle.
- 🔐 **Authentication** — Optional Supabase-backed accounts for syncing preferences.
- 📱 **Cross-Platform** — Built with Flutter, runs on Android, iOS, Web, Windows, macOS, and Linux.

---

## Screenshots

*(Add screenshots here)*

---

## Installation

### Mobile (Android / iOS)

1. Download the latest APK from the [Releases](https://github.com/shipblueprint/gut-sync/releases) page (Android).
2. Or build from source (see [Development](#development) below).

### Desktop (Windows / macOS / Linux)

Build from source using Flutter desktop support.

### Web

Visit the hosted version (if available) or build with:
```bash
flutter build web
```

---

## Project Structure

```
gut_sync/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── app_constant.dart            # Constants & version info
│   ├── app/
│   │   ├── controller/              # GetX controllers
│   │   │   ├── app_binding.dart     # Dependency injection bindings
│   │   │   ├── auth_controller.dart # Authentication logic
│   │   │   └── food_controller.dart # Food data management
│   │   ├── data/
│   │   │   └── food_repository.dart # Data access layer
│   │   └── model/
│   │       ├── diet_profile.dart    # Diet profile definitions
│   │       ├── food_category.dart   # Food category model
│   │       ├── food_item.dart       # Individual food item
│   │       └── food_status.dart     # Green/Yellow/Red status enum
│   ├── controller/
│   │   └── my_controller.dart       # Base controller
│   ├── helpers/
│   │   ├── extensions/              # Dart extension methods
│   │   ├── services/                # Core services
│   │   │   ├── app_config.dart      # App configuration
│   │   │   ├── auth_service.dart    # Supabase auth
│   │   │   ├── error_handler.dart   # Error handling
│   │   │   ├── json_decoder.dart    # JSON utilities
│   │   │   ├── localizations/       # i18n (5 languages)
│   │   │   ├── logger.dart          # Logging
│   │   │   ├── navigation_services.dart
│   │   │   ├── storage/             # Local storage
│   │   │   ├── supabase_service.dart# Supabase client
│   │   │   └── translations_service.dart
│   │   ├── theme/                   # Themming (dark/light)
│   │   ├── utils/                   # Utilities & mixins
│   │   └── widgets/                 # Reusable UI components
│   ├── route/                       # GoRouter routing
│   ├── view/                        # Screen pages
│   │   ├── app_layout/
│   │   ├── apps/
│   │   │   ├── auth/
│   │   │   ├── detail/
│   │   │   ├── favorites/
│   │   │   ├── home/
│   │   │   ├── settings/
│   │   │   └── splash/
│   │   └── ...
│   └── widgets/                     # Custom widgets
├── assets/
│   ├── data/                        # JSON diet databases
│   │   ├── food_data.json           # SIBO food database
│   │   ├── ssrd_data.json           # SSRD food database
│   │   ├── bile_data.json           # Bile reflux food database
│   │   └── 6fedlr_data.json         # 6FED-LR food database
│   ├── images/                      # App images & assets
│   └── lang/                        # Language files (AR, EN, ES, FR, HI)
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── test/
├── pubspec.yaml
└── README.md
```

---

## Diet Profiles

| Diet | ID | Description | Food Count* |
|------|----|-------------|-------------|
| **SIBO** | `sibo` | Low FODMAP foods for SIBO management | 200+ |
| **SSRD** | `ssrd` | Starch- and sucrose-reduced diet | 150+ |
| **Bile Reflux** | `bile_reflux` | Low-fat, low-acid foods | 100+ |
| **6FED-LR** | `6fedlr` | Six-food elimination & low-residue diet | 150+ |

*\*Approximate, varies by data version.*

### Food Status Legend

| Status | Color | Meaning |
|--------|-------|---------|
| 🟢 Green | `#4ADE80` | Allowed — safe to eat |
| 🟡 Yellow | `#FBBF24` | Caution — limited amounts or individual tolerance |
| 🔴 Red   | `#F87171` | Avoid — not recommended |

---

## Usage

1. **Select your diet** — Choose from SIBO, SSRD, Bile Reflux, or 6FED-LR on the home screen.
2. **Browse categories** — Foods are grouped by category (vegetables, fruits, grains, proteins, etc.).
3. **Check status** — Each item shows a green/yellow/red indicator.
4. **Search** — Use the search bar to quickly find a specific food.
5. **Favorite** — Tap the star icon to save foods for quick reference.
6. **View details** — Tap a food item to see its status, category, and any notes.
7. **Settings** — Change theme, language, or manage your account.

---

## Development

### Prerequisites
- **Flutter SDK** ^3.5.2
- **Dart SDK** ^3.5.2
- An IDE (VS Code, Android Studio, or IntelliJ)

### Setup

```bash
# Clone the repository
git clone https://github.com/shipblueprint/gut-sync.git
cd gut-sync/app

# Install dependencies
flutter pub get

# Generate localization files (if needed)
flutter gen-l10n

# Run on your target platform
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS + Xcode)
flutter build ios --release

# Web
flutter build web

# Windows
flutter build windows

# macOS
flutter build macos

# Linux
flutter build linux
```

### Key Dependencies

| Package | Purpose |
|---------|---------|
| `get` | State management & dependency injection |
| `go_router` | Declarative routing |
| `supabase_flutter` | Backend authentication & data sync |
| `dio` | HTTP networking |
| `shared_preferences` | Local key-value storage |
| `google_fonts` | Custom typography |
| `flutter_lucide` | Icon set |
| `intl` | Internationalization |

---

## Data

Food databases are stored as JSON files in `assets/data/`. Each diet has its own file:

- `food_data.json` — SIBO / Low FODMAP
- `ssrd_data.json` — Starch- and sucrose-reduced
- `bile_data.json` — Bile reflux
- `6fedlr_data.json` — 6-food elimination & low-residue

The data structure includes food names, categories, status (green/yellow/red), and optional notes.

---

## Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check the [issues page](https://github.com/shipblueprint/gut-sync/issues).

Ways to contribute:
- 🥦 Add or update food data entries
- 🌐 Improve translations
- 🐛 Report bugs or suggest features
- 📝 Improve documentation

---

## License

[ISC](https://opensource.org/licenses/ISC) — see [LICENSE](LICENSE) (if applicable).

---

*Built with [Flutter](https://flutter.dev/) and 💚 for the gut health community.*
