import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/domain/dtos/menu/menu_translation_response.dart';
import '../../../config/theme/color.dart';
import '../../../core/router/router.dart';

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
  bool received = true;
  bool isLoading = false;

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryWhite,
        body: received
            ? Stack(
                children: [
                  Positioned(
                      top: 90,
                      left: 0,
                      right: 0,
                      bottom: 200,
                      child: Image.file(
                        File(widget.params.filePath),
                        fit: BoxFit.fill,
                      )),
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
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: mainColor,
              )),
      ),
    );
  }
}
