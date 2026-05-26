import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_config.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // TODO: FIREBASE - Initialize Firebase
  // await Firebase.initializeApp();
  
  // TODO: HIVE - Initialize local storage
  // await Hive.initFlutter();
  
  runApp(const ProviderScope(child: QuickPedApp()));
}

class QuickPedApp extends ConsumerWidget {
  const QuickPedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'QuickPed',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
      localizationsDelegates: const [
        // TODO: LOCALIZATION - Add language support
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        // TODO: Add more locales as needed
      ],
    );
  }
}
