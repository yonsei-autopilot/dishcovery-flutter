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
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Scaffold(
        backgroundColor: primaryWhite,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
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
                      color: const Color(0xffD9D9D9),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: _loginIdController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Login Id',
                      ),
                      style: const TextStyle(fontSize: 14, color: primaryGrey),
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
                      color: const Color(0xffD9D9D9),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          suffixIcon: Icon(CupertinoIcons.eye_slash, color: primaryGrey),
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                        ),
                        style: const TextStyle(fontSize: 14, color: primaryGrey),
                      ),
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
                    height: 35,
                  ),
                  // login button
                  GestureDetector(
                      child: Container(
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
                          height: 50,
                          width: width - 110,
                          child: const Center(child: BodyText(text: 'Log In', color: primaryWhite, size: 20,))
                      ),
                      onTap: () {
                        final loginId = _loginIdController.text.trim();
                        final password = _passwordController.text.trim();
                        ref.read(authNotifierProvider.notifier).simpleLogin(loginId, password);
                      }
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: (width-155)/2,
                        height: 1,
                        color: const Color(0xffCFCFCF),
                      ),
                      const BodyText(text: "OR", color: const Color(0xffCFCFCF), size: 12,),
                      Container(
                        width: (width-155)/2,
                        height: 1,
                        color: const Color(0xffCFCFCF),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  // google login button
                  GestureDetector(
                    child: Image.asset(
                      'assets/images/google_login.png',
                      height: 34,
                    ),
                    onTap: () {
                      ref.read(authNotifierProvider.notifier).googleLogin();
                    },
                  ),
                  const SizedBox(
                    height: 30,
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
          ),
        ));
  }
}
