import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/presentation/providers/providers.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUseCase = ref.read(loginUseCaseProvider);

    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          loginUseCase.call();
        },
        child: const Text('로그인'),
      ),
    );
  }
}
