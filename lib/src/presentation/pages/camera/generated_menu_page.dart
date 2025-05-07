import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import '../../../config/theme/color.dart';

typedef GeneratedMenuPageParams = ({
  String filePath,
  MenuTranslationResponse response
});

class GeneratedMenuPage extends ConsumerStatefulWidget {
  const GeneratedMenuPage({super.key, required this.params});
  final GeneratedMenuPageParams params;

  @override
  GeneratedMenuPageState createState() => GeneratedMenuPageState();
}

class GeneratedMenuPageState extends ConsumerState<GeneratedMenuPage> {
  final TransformationController _controller = TransformationController();

  bool isLoading = true;
  bool isScaling = false;

  ui.Image? _imageInfo;

  @override
  void initState() {
    super.initState();
    _loadImageInfo();
  }

  Future<void> _loadImageInfo() async {
    final bytes = await File(widget.params.filePath).readAsBytes();
    ui.decodeImageFromList(bytes, (img) {
      setState(() {
        _imageInfo = img;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: primaryWhite,
        body: Center(
            child: CircularProgressIndicator(
          color: primaryWhite,
        )),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final imageAspect = _imageInfo!.width / _imageInfo!.height;
    final displayWidth = screenWidth;
    final displayHeight = screenWidth / imageAspect;

    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: 90,
        child: InteractiveViewer(
          transformationController: _controller,
          panEnabled: true,
          scaleEnabled: true,
          minScale: 1.0,
          maxScale: 4.0,
          // Transformation 시작
          onInteractionStart: (_) => setState(() => isScaling = true),
          // Transformation 종료
          onInteractionEnd: (_) => setState(() => isScaling = false),
          child: SizedBox(
            width: displayWidth,
            height: displayHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    File(widget.params.filePath),
                    fit: BoxFit.fill,
                  ),
                ),
                ...widget.params.response.items.map((item) {
                  var [ymin, xmin, ymax, xmax] = item.boundingBox;
                  final left = xmin / 1000 * displayWidth;
                  final top = ymin / 1000 * displayHeight;
                  final w = (xmax - xmin) / 1000 * displayWidth;
                  final h = (ymax - ymin) / 1000 * displayHeight;
                  return Positioned(
                      left: left,
                      top: top,
                      width: w,
                      height: h,
                      child: IgnorePointer(
                        ignoring: isScaling,
                        child: GestureDetector(
                          // 여기서 상세 페이지 이동
                          onTap: () => print(item.toJson()),
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Text(
                              item.translatedItemName,
                              style: const TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ));
                }),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 52,
        left: 0,
        right: 0,
        child: Center(
          child: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: mainColor,
              size: 42,
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              Future.microtask(() async {
                ref.read(routerProvider).go('/');
              });
            },
          ),
        ),
      )
    ]));
  }
}
