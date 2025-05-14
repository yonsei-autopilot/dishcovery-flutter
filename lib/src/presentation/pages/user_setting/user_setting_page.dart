import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
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

    return SizedBox(
      width: width*0.85,
      child: Drawer(
          backgroundColor: primaryWhite,
          child: Stack(
            children: [
              const Positioned(
                top: 85,
                left: 40,
                child: BodyText(text: 'Welcome!', color: Color(0xff8C8C8C), size: 15,),
              ),
              const Positioned(
                top: 120,
                left: 45,
                child: UserProfileWidget(),
              ),
              Positioned(
                top: 225,
                left: 35,
                child: Column(
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        width: (width * 0.8) - 55,
                        height: 60,
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            BodyText(
                              text: 'Allergies and Preferences',
                              size: 16,
                              color: primaryBlack,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                CupertinoIcons.chevron_right,
                                color: primaryBlack,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        ref.read(routerProvider).push('/preferences');
                      },
                    ),
                    Container(
                      height: 1,
                      width: (width * 0.8) - 55,
                      color: const Color(0xffCFCFCF),
                    ),
                    GestureDetector(
                      child: SizedBox(
                        width: (width * 0.8) - 55,
                        height: 60,
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            BodyText(
                              text: 'Translating Language',
                              size: 16,
                              color: primaryBlack,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                CupertinoIcons.chevron_right,
                                color: primaryBlack,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        ref.read(routerProvider).push('/language');
                      },
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(color: primaryGrey),
                ),
            ],
          )),
    );
  }
}
