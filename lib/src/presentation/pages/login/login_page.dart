import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Scaffold(
        backgroundColor: primaryWhite,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Image.asset(
                  'assets/images/green_logo.png',
                  width: 88,
                ),
                const SizedBox(
                  height: 40,
                ),
                // id
                Container(
                  height: 58,
                  width: width - 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      color: const Color(0xffD9D9D9)),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(29, 20, 0, 0),
                    child: BodyText(text: 'E-Mail', size: 14, color: primaryGrey),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                // password
                Container(
                  height: 58,
                  width: width - 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(29),
                      color: const Color(0xffD9D9D9)),
                  child: const Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 29,
                        child: BodyText(
                            text: 'Password', size: 14, color: primaryGrey),
                      ),
                      Positioned(
                        top: 20,
                        right: 18,
                        child: Icon(
                          CupertinoIcons.eye_slash,
                          color: primaryGrey,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    Icon(CupertinoIcons.circle, size: 10, color: primaryGrey),
                    SizedBox(
                      width: 2,
                    ),
                    BodyText(
                      text: "Remember Me",
                      size: 12,
                      color: primaryGrey,
                    )
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                // google login button
                GestureDetector(
                    child: Image.asset(
                      'assets/images/google_login.png',
                      height: 34,
                    ),
                    onTap: () {
                      ref.read(authNotifierProvider.notifier).loginWithGoogle();
                    }),
                const SizedBox(
                  height: 30,
                ),
                // login button
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(24)),
                      height: 50,
                      width: width - 110,
                      child: const Center(child: BodyText(text: 'Login', color: primaryWhite, size: 20,))
                  ),
                ),
                // 임시 버튼
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const BodyText(
                    text: 'camera page',
                    color: primaryRed,
                  ),
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).test();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
