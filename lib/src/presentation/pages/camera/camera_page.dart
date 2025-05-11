import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/camera_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';
import '../../../config/theme/color.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends ConsumerState<CameraPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cameraControllerProvider);

    return Scaffold(
      backgroundColor: primaryWhite,
      body: switch (state) {
        CInitial() || CLoading() => const Center(
            child: CircularProgressIndicator(color: primaryWhite),
          ),
        CReady(:final controller) => Stack(
            children: [
              Positioned.fill(
                top: 90,
                bottom: 200,
                left: 0,
                right: 0,
                child: DocumentScanner(
                  controller: controller,
                  onSave: (_) {},
                ),
              ),
              Positioned(
                top: 28,
                left: 33,
                child: IconButton(
                  icon: Icon(CupertinoIcons.person, color: mainColor, size: 33),
                  onPressed: () {
                    ref.read(routerProvider).push('/user_setting');
                  },
                ),
              ),
              Positioned(
                bottom: 52,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.radio_button_checked,
                            size: 96, color: mainColor),
                        onPressed: () {
                          ref
                              .read(cameraControllerProvider.notifier)
                              .takePicture();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.photo_library,
                            size: 40, color: mainColor),
                        onPressed: () {
                          ref
                              .read(cameraControllerProvider.notifier)
                              .selectPicture();
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        CCapturing() => Center(
            child: BodyText(text: 'Processing...', color: mainColor),
          ),
        CCapturedSuccess() => const SizedBox.shrink(),
        CError() => Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(cameraControllerProvider.notifier).initialize();
              },
              child: const BodyText(text: 'Retry\n', color: primaryWhite),
            ),
          ),
      },
    );
  }
}
