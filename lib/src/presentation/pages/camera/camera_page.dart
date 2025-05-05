import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/camera_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/pages/camera/generating_page.dart';
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
    Future.microtask(() async {
      final permissionUseCase = ref.read(permissionUseCaseProvider);
      final hasLocationPermission = await permissionUseCase.checkLocation();
      final hasCameraPermission = await permissionUseCase.checkCamera();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      ref.read(cameraControllerProvider.notifier).safeDispose();
    } else if (state == AppLifecycleState.resumed) {
      ref.read(cameraControllerProvider.notifier).initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cameraControllerProvider);

    return Scaffold(
      backgroundColor: primaryWhite,
      body: switch (state) {
        CInitial() || CLoading() => const Center(
            child: CircularProgressIndicator(
              color: primaryWhite,
            ),
          ),
        CReady(:final controller) => Stack(
            children: [
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                bottom: 200,
                child: CameraPreview(controller),
              ),
              Positioned(
                top: 28,
                left: 33,
                child: IconButton(
                  onPressed: () {
                    ref.read(routerProvider).go('/user_setting');
                  },
                  icon: Icon(
                    CupertinoIcons.person,
                    color: mainColor,
                    size: 33,
                  ),
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
                      const Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft, child: SizedBox()),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.radio_button_checked,
                                size: 96, color: mainColor),
                            onPressed: () => ref
                                .read(cameraControllerProvider.notifier)
                                .takePicture(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.photo_library,
                                size: 40, color: mainColor),
                            onPressed: () => ref
                                .read(cameraControllerProvider.notifier)
                                .selectPicture(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        CCapturing() => Center(
              child: BodyText(
            text: 'Capturing Image...',
            color: mainColor,
          )),
        CCapturedSuccess(:final file) => Builder(builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/generating', extra: (filePath: file.path));
            });
            return const SizedBox();
          }),
        CError(:final error) => ElevatedButton(
            child: const BodyText(
              text: "Retry",
              color: primaryWhite,
            ),
            onPressed: () =>
                ref.read(cameraControllerProvider.notifier).initialize(),
          ),
      },
    );
  }
}
