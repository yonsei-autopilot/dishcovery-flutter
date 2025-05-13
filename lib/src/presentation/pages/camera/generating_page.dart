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
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final response = await ref
          .read(menuUsecaseProvider)
          .analyzeMenuImage(widget.params.filePath);
      ref.read(routerProvider).go('/generated_menu', extra: (
        filePath: widget.params.filePath,
        response: response,
      ));
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
              text: 'Generating Menu...',
              color: mainColor,
            ),
            // // bounding box 이전 임시 버튼
            // const SizedBox(height: 15,),
            // ElevatedButton(
            //   onPressed: () {
            //     ref.read(routerProvider).push(
            //         '/menu_detail',
            //         extra: (
            //           menuName: 'とんこつラーメン'
            //         )
            //     );
            //   },
            //   child: const BodyText(text: 'menu detail'),
            // )
          ],
        ),
      ),
    );
  }
}
