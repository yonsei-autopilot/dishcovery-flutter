import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/config/theme/body_text.dart';
import 'package:smart_menu_flutter/src/config/theme/color.dart';
import 'package:smart_menu_flutter/src/presentation/notifiers/auth_notifier.dart';
import '../../states/auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _rememberId = false;

  @override
  void initState() {
    _passwordVisible = false;
    _rememberId = false;
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
    final authState = ref.watch(authNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState is AuthenticationError) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const BodyText(text: '로그인 실패'),
            content: BodyText(text: authState.message),
            backgroundColor: primaryWhite,
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(authNotifierProvider.notifier).clearError();
                  Navigator.of(ctx).pop();
                },
                child: const BodyText(text: '확인'),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
        backgroundColor: primaryWhite,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/logo_small.png',
                    width: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // id
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: InnerShadow(
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(1, 2))
                      ],
                      child: Container(
                        height: 58,
                        width: width - 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffD9D9D9),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 29),
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          controller: _loginIdController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Login/E-Mail',
                              hintStyle: TextStyle(
                                  fontFamily: 'SFProRegular',
                                  fontSize: 14,
                                  color: primaryGrey)),
                          style:
                              const TextStyle(fontSize: 14, color: primaryGrey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  // password
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: InnerShadow(
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(1, 2))
                      ],
                      child: Container(
                        height: 58,
                        width: width - 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffD9D9D9),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 29),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  fontFamily: 'SFProRegular',
                                  fontSize: 14,
                                  color: primaryGrey),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: primaryGrey,
                                ),
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 18),
                            ),
                            style: const TextStyle(
                                fontSize: 14, color: primaryGrey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 70,
                      ),
                      GestureDetector(
                        child: _rememberId
                            ? const Icon(Icons.check_circle_outline_rounded,
                                size: 18, color: primaryGrey)
                            : const Icon(Icons.circle_outlined,
                                size: 18, color: primaryGrey),
                        onTap: () {
                          setState(() {
                            _rememberId = !_rememberId;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const BodyText(
                        text: "Remember Me",
                        size: 12,
                        color: primaryGrey,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Center(
                    child: BodyText(
                      text: 'Don\'t have an account?',
                      size: 12,
                      weight: FontWeight.bold,
                      color: primaryGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          height: 50,
                          width: width - 110,
                          child: const Center(
                              child: BodyText(
                            text: 'Log In',
                            color: primaryWhite,
                            size: 20,
                          ))),
                      onTap: () {
                        final loginId = _loginIdController.text.trim();
                        final password = _passwordController.text.trim();
                        ref
                            .read(authNotifierProvider.notifier)
                            .simpleLogin(loginId, password);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: (width - 155) / 2,
                        height: 1,
                        color: const Color(0xffCFCFCF),
                      ),
                      const BodyText(
                        text: "OR",
                        color: Color(0xffCFCFCF),
                        size: 12,
                      ),
                      Container(
                        width: (width - 155) / 2,
                        height: 1,
                        color: const Color(0xffCFCFCF),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                ],
              ),
            ),
          ),
        ));
  }
}
