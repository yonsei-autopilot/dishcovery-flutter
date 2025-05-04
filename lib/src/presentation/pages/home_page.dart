import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/camera_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final permissionUseCase = ref.read(permissionUseCaseProvider);
      final hasLocationPermission = await permissionUseCase.checkLocation();
      final hasCameraPermission = await permissionUseCase.checkCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cameraControllerProvider);

    return Scaffold(
      body: switch (state) {
        CInitial() || CLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        CReady(:final controller) => CameraPreview(controller),
        CCapturing() => const Center(child: BodyText(text: "Taking Photo...")),
        CCapturedSuccess(:final file) => Image.file(File(file.path)),
        CError(:final error) => ElevatedButton(
            child: const BodyText(text: "Retry"),
            onPressed: () =>
                ref.read(cameraControllerProvider.notifier).initialize(),
          ),
      },
      floatingActionButton: state is CReady
          ? FloatingActionButton(
              onPressed: () =>
                  ref.read(cameraControllerProvider.notifier).takePicture(),
              child: const Icon(CupertinoIcons.camera_fill),
            )
          : null,
    );
  }
}
