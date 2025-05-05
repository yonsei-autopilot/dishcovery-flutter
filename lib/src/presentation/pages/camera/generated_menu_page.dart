import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme/color.dart';
import '../../../core/router/router.dart';
import '../../notifiers/camera_notifier.dart';

class GeneratedMenuPage extends ConsumerStatefulWidget {
  const GeneratedMenuPage({super.key, required this.filePath});
  final String filePath;

  @override
  GeneratedMenuPageState createState() => GeneratedMenuPageState();
}

class GeneratedMenuPageState extends ConsumerState<GeneratedMenuPage> {
  bool received = true;
  bool isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: primaryWhite,)),
      );
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: received ? Stack(
          children: [
            Positioned(
              top: 90,
              left: 0,
              right: 0,
              bottom: 200,
              child: Image.file(
                File(widget.filePath),
                fit: BoxFit.fill,
              )
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
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: primaryWhite,
                    size: 42,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    Future.microtask(() async {
                      await ref.read(cameraControllerProvider.notifier).initialize();
                      ref.read(routerProvider).go('/');
                    });
                  },
                ),
              ),
            )
          ],
        ) : const Center(child: CircularProgressIndicator(color: primaryWhite,)),
      ),
    );
  }
}
