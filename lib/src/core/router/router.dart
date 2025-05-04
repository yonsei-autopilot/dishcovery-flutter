import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/presentation/pages/home_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/login_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: '/login', routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage())
  ]);
});
