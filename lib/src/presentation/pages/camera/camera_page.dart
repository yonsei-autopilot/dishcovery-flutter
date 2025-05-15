import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/domain/usecases/permission_usecase.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/camera_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/user_setting_page.dart';
import 'package:smart_menu_flutter/src/presentation/states/camera_state.dart';
import '../../../config/theme/color.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends ConsumerState<CameraPage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryWhite,
      drawer: const UserSettingPage(),
      body: switch (state) {
        CInitial() || CLoading() => const Center(
            child: CircularProgressIndicator(
              color: primaryWhite,
            ),
          ),
        CReady(:final controller) => Stack(
            children: [
              OverflowBox(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    height: size.height,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 33,
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: primaryWhite,
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(Icons.photo_library,
                                size: 40, color: primaryWhite),
                            onPressed: () => ref
                                .read(cameraControllerProvider.notifier)
                                .selectPicture(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.radio_button_checked,
                                size: 96, color: primaryWhite),
                            onPressed: () => ref
                                .read(cameraControllerProvider.notifier)
                                .takePicture(),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        CCapturing() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: mainColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BodyText(
                    text: 'Capturing Image...',
                    color: mainColor,
                  ),
                ],
              )),
        CCapturedSuccess(:final file) => Builder(builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.push('/generating', extra: (filePath: file.path));
            });
            return const SizedBox();
          }),
        CError(:final error) => Center(
          child: ElevatedButton(
              child: const BodyText(
                text: "Retry",
                color: primaryWhite,
              ),
              onPressed: () =>
                  ref.read(cameraControllerProvider.notifier).initialize(),
            ),
        ),
      },
    );
  }
}
