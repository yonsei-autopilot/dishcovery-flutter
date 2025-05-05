import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_explain_response.dart';
import 'package:smart_menu_flutter/src/presentation/pages/camera/generated_menu_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/camera/camera_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/camera/generating_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/login/login_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/preferences_page.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/user_setting_page.dart';
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
              context: context, state: state, child: const CameraPage())),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
          path: '/user_setting',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const UserSettingPage())),
      GoRoute(
        path: '/generated_menu',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: GeneratedMenuPage(
              params: state.extra as GeneratedMenuPageParams,
            ),
          );
        },
      ),
      GoRoute(
        path: '/generating',
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: GeneratingPage(
              params: state.extra as GeneratingPageParams,
            ),
          );
        },
      ),
      GoRoute(
          path: '/preferences',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
              context: context, state: state, child: const PreferencesPage())),
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
