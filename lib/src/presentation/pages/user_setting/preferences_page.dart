import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme/body_text.dart';
import '../../../config/theme/color.dart';

class PreferencesPage extends ConsumerStatefulWidget {
  const PreferencesPage({super.key});

  @override
  PreferencesPageState createState() => PreferencesPageState();
}

class PreferencesPageState extends ConsumerState<PreferencesPage> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double width = size.width;

    return Scaffold(
      backgroundColor: primaryWhite,
      body: SafeArea(
        child: Stack(
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
                  onTap: () {
                    context.pop();
                  },
                )),
            const Positioned(
              top: 75,
              left: 0,
              right: 0,
              child: Center(
                  child: BodyText(
                text: 'Allergies and Preferences',
                size: 20,
                color: primaryBlack,
              )),
            ),
            const Positioned(
              top: 140,
              left: 0,
              right: 0,
              child: Center(
                child: BodyText(
                  text: 'Choose which allergies or ingredients to be\nalerted about.',
                  size: 16,
                  color: primaryBlack,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
