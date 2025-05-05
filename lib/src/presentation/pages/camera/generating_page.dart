import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/menu_usecase.dart';
import '../../../config/theme/color.dart';

class GeneratingPage extends ConsumerStatefulWidget {
  const GeneratingPage({super.key, required this.filePath});
  final String filePath;

  @override
  GeneratingPageState createState() => GeneratingPageState();
}

class GeneratingPageState extends ConsumerState<GeneratingPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final response =
          await ref.read(menuUsecaseProvider).analyzeMenuImage(widget.filePath);
      ref.read(routerProvider).go('/generated_menu', extra: {
        'filePath': widget.filePath,
        'response': response,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: mainColor,
            ),
            BodyText(
              text: 'Generating Menu...',
              color: mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
