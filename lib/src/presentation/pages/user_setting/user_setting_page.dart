import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/food_aversion_notifier.dart';
import 'package:smart_menu_flutter/src/presentation/pages/user_setting/widget/user_profile_widget.dart';
import '../../../config/theme/color.dart';
import '../../../core/router/router.dart';

class UserSettingPage extends ConsumerStatefulWidget {
  const UserSettingPage({super.key});

  @override
  UserSettingPageState createState() => UserSettingPageState();
}

class UserSettingPageState extends ConsumerState<UserSettingPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  Future.microtask(() async {
                    ref.read(routerProvider).go('/');
                  });
                },
              )),
          const Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Center(
                child: BodyText(
              text: 'Settings',
              size: 20,
              color: primaryBlack,
            )),
          ),
          const Positioned(
            top: 160,
            child: UserProfileWidget(),
          ),
          Positioned(
            top: 280,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  width: width - 100,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9), color: mainColor),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BodyText(
                        text: 'Allergies and Preferences',
                        size: 16,
                        color: primaryWhite,
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: primaryWhite,
                        size: 24,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // aversion widget test code
                  ref.read(aversionsProvider.notifier).test();
                  ref.read(routerProvider).push('/preferences');
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
    ));
  }
}
