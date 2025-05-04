import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:smart_menu_flutter/src/presentation/pages/camera/generated_menu_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/camera/home_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/login/login_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting_page.dart';
import 'package:smart_menu_flutter/src/presentation/states/auth_state.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/auth_notifier.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == '/login';

      if (authState is Unauthenticated) {
        return loggingIn ? null : '/login';
      }

      if (authState is Authenticated && loggingIn) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const HomePage()
          )
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/user_setting', builder: (context, state) => const UserSettingPage()),
      GoRoute(
        path: '/generated_menu',
        pageBuilder: (context, state) {
          final filePath = state.extra as String;
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: GeneratedMenuPage(filePath: filePath),
          );
        },
      )
    ],
  );
});

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  }) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}