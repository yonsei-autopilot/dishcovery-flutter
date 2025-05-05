import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/camera_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';
import '../../../config/theme/color.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() async {
      final permissionUseCase = ref.read(permissionUseCaseProvider);
      final hasLocationPermission = await permissionUseCase.checkLocation();
      final hasCameraPermission = await permissionUseCase.checkCamera();
      // ref.read(cameraControllerProvider.notifier).initialize();
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
      ref.read(cameraControllerProvider.notifier).dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cameraControllerProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: switch (state) {
        CInitial() || CLoading() => const Center(
            child: CircularProgressIndicator(color: primaryWhite,),
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
                icon: const Icon(
                  CupertinoIcons.person,
                  color: primaryWhite,
                  size: 33,
                ),
              ),
            ),
            Positioned(
              bottom: 52,
              left: 0,
              right: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.radio_button_checked, size: 96, color: primaryWhite,),
                  onPressed: () => ref.read(cameraControllerProvider.notifier).takePicture(),
                ),
              ),
            )
          ],
        ),
        CCapturing() => const Center(child: BodyText(text: "Taking Photo...", color: primaryWhite,)),
        CCapturedSuccess(:final file) => Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/generated_menu', extra: file.path);
            }
          );
          return const Center(child: BodyText(text: 'Generating Menu...', color: primaryWhite,));
          }
        ),
        CError(:final error) => ElevatedButton(
            child: const BodyText(text: "Retry", color: primaryWhite,),
            onPressed: () =>
                ref.read(cameraControllerProvider.notifier).initialize(),
          ),
      },
    );
  }
}
