import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';

class UserSettingPage extends ConsumerWidget {
  const UserSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BodyText(text: 'User Setting Page'),
      ),
    );
  }
}
