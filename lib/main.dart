import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final appInitializationProvider = FutureProvider<void>((ref) async {
  await dotenv.load();
  await Firebase.initializeApp();
});

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final prefs = await SharedPreferences.getInstance();


  runApp(ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appInit = ref.watch(appInitializationProvider);

    return appInit.when(
      loading: () => const MaterialApp(home: SizedBox.shrink()),
      error: (err, stack) => MaterialApp(
        home: Scaffold(
          body: Center(child: BodyText(text: '초기화 에러: $err'),),
        ),
      ),
      data: (_) {
        FlutterNativeSplash.remove();
        final goRouter = ref.watch(routerProvider);
        return MaterialApp.router(
          title: 'DishCovery',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              canvasColor: primaryWhite
          ),
          routerDelegate: goRouter.routerDelegate,
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
        );
      }
    );
  }
}
