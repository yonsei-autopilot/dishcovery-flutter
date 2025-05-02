import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/presentation/providers/providers.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUseCase = ref.read(loginUseCaseProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            loginUseCase.call();
          },
          child: const BodyText(text: "login", color: primaryRed,),
        ),
      ),
    );
  }
}
