import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone/features/auth/view/signup_view.dart';
import 'package:x_clone/features/auth/widgets/auth_field.dart';
import 'package:x_clone/theme/pallete.dart';

import '../../../common/common.dart';
import '../../../constants/ui_constants.dart';
import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => LoginView(),
      );

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar(); // 変数にすることで、何度も呼ばれない
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // e-mail
                      AuthField(
                        controller: emailController,
                        hintText: 'Email address',
                      ),
                      SizedBox(height: 25),
                      // password
                      AuthField(
                        controller: passwordController,
                        hintText: 'パスワード',
                      ),
                      SizedBox(height: 40),
                      // button
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: onLogin, // ログイン処理
                          label: "Done",
                        ),
                      ),
                      SizedBox(height: 40),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: " Sign up",
                                style: TextStyle(
                            color: Pallete.blueColor,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                SignUpView.route(),
                              );
                            },
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
