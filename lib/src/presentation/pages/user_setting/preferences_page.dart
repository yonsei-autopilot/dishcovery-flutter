import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/food_aversion_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/widget/checked_food_widget.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/widget/food_scroll_view.dart';
import '../../../config/theme/body_text.dart';
import '../../../config/theme/color.dart';

class PreferencesPage extends ConsumerStatefulWidget {
  const PreferencesPage({super.key});

  @override
  PreferencesPageState createState() => PreferencesPageState();
}

class PreferencesPageState extends ConsumerState<PreferencesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(aversionsProvider.notifier).initializeAversions();
    });
  }

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
            left: 35,
            right: 35,
            child: BodyText(
              text: 'Choose which allergies, ingredients, or culturally / religiously restricted foods to watch out for:',
              overflow: TextOverflow.clip,
              size: 16,
              color: primaryBlack,
            ),
          ),
          const Positioned(
            top: 200,
            left: 35,
            right: 35,
            child: CheckedFoodWidget(),
          ),
          const Positioned(
            top: 270,
            left: 35,
            right: 35,
            child: FoodScrollView(),
          ),
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
                            offset: const Offset(0, 3))
                      ]),
                  child: const Center(
                      child: BodyText(
                    text: 'Save',
                    color: primaryWhite,
                    size: 14,
                  )),
                ),
                onTap: () async {
                  await ref.read(aversionsProvider.notifier).saveAversions();
                  context.pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
