import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/core/router/router.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/cart_notifier.dart';
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
    const heightScaleFactor = 1.2;
    const fontScaleFactor = 0.7;

    final cartItems = ref.watch(cartProvider);

    final Map<String, int> menuCountMap = {};
    var menuCount = 0;

    for (final item in cartItems) {
      menuCountMap[item.menuName] = item.count;
      menuCount += item.count;
    }

    return Scaffold(
      backgroundColor: primaryWhite,
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              transformationController: _controller,
              panEnabled: true,
              scaleEnabled: true,
              minScale: 1.0,
              maxScale: 4.0,
              onInteractionStart: (_) => setState(() => isScaling = true),
              onInteractionEnd: (_) => setState(() => isScaling = false),
              child: Center(
                child: SizedBox(
                  width: displayWidth,
                  height: displayHeight,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(
                          File(widget.params.filePath),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      ...widget.params.response.items.map((item) {
                        var [ymin, xmin, ymax, xmax] = item.boundingBox;
                        final left = xmin / 1000 * displayWidth;
                        final top = ymin / 1000 * displayHeight;
                        final height = (ymax - ymin) *
                            heightScaleFactor /
                            1000 *
                            displayHeight;
                        final fontSize = height * fontScaleFactor;
                        final isInCart =
                            menuCountMap.containsKey(item.translatedItemName);

                        return Positioned(
                          left: left,
                          top: top,
                          height: height,
                          child: IgnorePointer(
                            ignoring: isScaling,
                            child: GestureDetector(
                              onTap: () {
                                ref.read(routerProvider).push(
                                  '/menu_detail',
                                  extra: (menuName: item.translatedItemName, availableOptions: item.availableOptions),
                                );
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: isInCart
                                          ? const Color.fromARGB(
                                              255, 205, 243, 26)
                                          : const Color.fromARGB(
                                              255, 230, 230, 230),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(20, 0, 0, 0),
                                          offset: Offset(0, 5),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      item.translatedItemName,
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  if (isInCart)
                                    Positioned(
                                      top: -10,
                                      right: -10,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Color.fromARGB(20, 0, 0, 0),
                                              offset: Offset(0, 5),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 15,
                                          minHeight: 15,
                                        ),
                                        child: Center(
                                          child: Text(
                                            menuCountMap[
                                                    item.translatedItemName]
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 35,
            child: Container(
              decoration: BoxDecoration(
                color: primaryBlack.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: primaryWhite,
                  size: 24,
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
          ),
          Positioned(
              top: 70,
              right: 35,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: primaryBlack.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.cart,
                        size: 25,
                        color: primaryWhite,
                      ),
                      onPressed: () {
                        ref.read(routerProvider).push('/menu_cart');
                      },
                    ),
                  ),
                  if (menuCount > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(20, 0, 0, 0),
                              offset: Offset(0, 5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Center(
                          child: Text(
                            menuCount.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
