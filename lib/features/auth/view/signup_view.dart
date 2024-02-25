import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:x_clone/constants/ui_constants.dart';
import 'package:x_clone/features/auth/view/login_view.dart';
import 'package:x_clone/features/auth/widgets/auth_field.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';

class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SignUpView(),
      );

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final appbar = UIConstants.appBar(); // 変数にすることで、何度も呼ばれない
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
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
                    onTap: () {},
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
                          text: " Login",
                          style: TextStyle(
                            color: Pallete.blueColor,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                LoginView.route(),
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
