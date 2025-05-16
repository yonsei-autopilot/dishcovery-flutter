import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/menu_usecase.dart';
import '../../../config/theme/color.dart';

typedef GeneratingPageParams = ({String filePath});

class GeneratingPage extends ConsumerStatefulWidget {
  const GeneratingPage({super.key, required this.params});

  final GeneratingPageParams params;

  @override
  GeneratingPageState createState() => GeneratingPageState();
}

class GeneratingPageState extends ConsumerState<GeneratingPage>
    with WidgetsBindingObserver {
  final List<String> _stepTexts = [
    'Analyzing menu image...',
    'Understanding menu structure...',
    'Translating menu items...',
    'Creating new menu layout...',
    'Taking a bit longer than expected...'
  ];

  int _currentStep = 0;
  Timer? _stepTimer;

  @override
  void initState() {
    super.initState();

    _stepTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return timer.cancel();
      if (_currentStep < _stepTexts.length - 1) {
        setState(() => _currentStep += 1);
      }
    });

    Future.microtask(() async {
      final response = await ref
          .read(menuUsecaseProvider)
          .analyzeMenuImage(widget.params.filePath);
      ref.read(routerProvider).go('/generated_menu', extra: (
        filePath: widget.params.filePath,
        response: response,
      ));
      String snippetOfForeignLanguage =
          response.items.map((item) => item.translatedItemName).join(' ');
      await ref
          .read(menuUsecaseProvider)
          .getLanguageCodeForGoogleCodeFromServer(snippetOfForeignLanguage);
      if (mounted) {
        _stepTimer?.cancel();
      }
      ref.read(routerProvider).go(
        '/generated_menu',
        extra: (
          filePath: widget.params.filePath,
          response: response,
        ),
      );
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
            const SizedBox(
              height: 15,
            ),
            BodyText(
              text: _stepTexts[_currentStep],
              color: mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
