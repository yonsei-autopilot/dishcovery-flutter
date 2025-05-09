import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/widget/language_dropdown_widget.dart';
import '../../../config/theme/body_text.dart';

class LanguagePage extends ConsumerStatefulWidget {
  const LanguagePage({super.key});

  @override
  LanguagePageState createState() => LanguagePageState();
}

class LanguagePageState extends ConsumerState<LanguagePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Stack(
        children: [
          Positioned(
              top: 75,
              left: 35,
              child: GestureDetector(
                child: const Icon(
                  CupertinoIcons.arrow_left,
                  size: 30,
                  color: primaryBlack,
                ),
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  context.pop();
                },
              )),
          const Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Center(
                child: BodyText(
                  text: 'Translating Language',
                  size: 20,
                  color: primaryBlack,
                )),
          ),
          const Positioned(
            top: 140,
            left: 35,
            right: 35,
            child: BodyText(
              text: 'Translate all menus to the following language:',
              overflow: TextOverflow.clip,
              size: 16,
              color: primaryBlack,
            ),
          ),
          // drop down
          const Positioned(
            top: 210,
            left: 35,
            right: 35,
            child: Center(child: LanguageDropdownWidget()),
          ),
          // 저장 버튼
          Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3)
                        )
                      ]
                  ),
                  child: const Center(child: BodyText(text: 'Save', color: primaryWhite, size: 14,)),
                ),
                // language 서버로 전송
                onTap: () {

                },
              ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(color: primaryGrey),
            ),
        ],
      ),
    );
  }
}
