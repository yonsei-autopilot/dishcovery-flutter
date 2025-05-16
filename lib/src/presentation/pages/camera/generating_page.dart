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
    'Consulting AI chef...'
  ];

  int _currentStep = 0;
  Timer? _stepTimer;
  Future<void>? _analysisFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _startAnalysis();
    });

    _stepTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_currentStep < _stepTexts.length - 1) {
          _currentStep += 1;
        }
      });
    });
  }


  void _startAnalysis() {
    _analysisFuture = _performImageAnalysis();
  }

  Future<void> _performImageAnalysis() async {
    final menuUsecase = ref.read(menuUsecaseProvider);
    final router = ref.read(routerProvider);

    try {
      final response = await menuUsecase.analyzeMenuImage(widget.params.filePath);

      if (!mounted) return;

      final snippet = response.items
          .map((item) => item.translatedItemName)
          .join(' ');

      await menuUsecase.getLanguageCodeForGoogleCodeFromServer(snippet);

      if (!mounted) return;

      router.go('/generated_menu', extra: (
      filePath: widget.params.filePath,
      response: response,
      ));
    } finally {
      if (mounted) {
        _stepTimer?.cancel();
      }
    }
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _analysisFuture?.ignore();
    super.dispose();
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
