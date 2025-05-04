import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/auth_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/states/auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).loginWithGoogle();
                },
                child: const BodyText(
                  text: "Google Login",
                  color: primaryRed,
                ),
              ),
              const SizedBox(height: 10,),
              // 임시 버튼
              ElevatedButton(
                child: const BodyText(text: 'camera page', color: primaryRed,),
                onPressed: () {
                   ref.read(authNotifierProvider.notifier).test();
                },
              )
            ],
          ),
        )
    );
  }
}
