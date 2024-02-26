import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone/common/common.dart';
import 'package:x_clone/features/auth/controller/auth_controller.dart';
import 'package:x_clone/features/auth/view/signup_view.dart';
import 'package:x_clone/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
              data: (user) {
                print(user);
                // if (user != null) {
                //   return const HomeView();
                // }
                return const SignUpView();
              },
              error: (e, st) => ErrorPage(
                error: e.toString(),
              ),
              loading: () => LoadingPage(),
            )
        // const SignUpView(),
        );
  }
}
