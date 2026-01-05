import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'data/local/hive_service.dart';
import 'presentation/routing/app_router.dart';
import 'state/providers/preferences_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const ProviderScope(child: EvenlyApp()));
}

class EvenlyApp extends StatelessWidget {
  const EvenlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final preferences = ref.watch(preferencesProvider);
        ThemeMode themeMode;
        switch (preferences.theme) {
          case 'light':
            themeMode = ThemeMode.light;
            break;
          case 'dark':
            themeMode = ThemeMode.dark;
            break;
          default:
            themeMode = ThemeMode.system;
        }

        return MaterialApp.router(
          title: 'Evenly',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
