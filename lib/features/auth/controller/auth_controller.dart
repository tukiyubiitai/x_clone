import 'package:appwrite/models.dart' as model;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone/apis/user_api.dart';
import 'package:x_clone/core/utils.dart';
import 'package:x_clone/features/auth/view/login_view.dart';
import 'package:x_clone/features/home/view/home_view.dart';
import 'package:x_clone/models/user_model.dart';

import '../../../apis/auth_api.dart';

// AuthControllerのインスタンスを作成し、アプリ全体で利用可能にするためのStateNotifierProviderを定義します。
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  // authAPIProviderからAuthAPIのインスタンスを取得し、AuthControllerに渡します。
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userApi: ref.watch(userAPIProvider),
  );
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

// AuthControllerは、認証関連の状態（この場合はローディング状態）とロジックを管理するクラスです。
class AuthController extends StateNotifier<bool> {
  // AuthAPIのインスタンスを保持します。これを通じて認証関連のAPI呼び出しを行います。
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  // コンストラクタ。AuthAPIのインスタンスを受け取り、初期状態をfalse（ローディングしていない）に設定します。
  AuthController({required AuthAPI authAPI, required UserAPI userApi})
      : _authAPI = authAPI,
        _userAPI = userApi,
        super(false);

  //　ユーザーが存在するかどうか確認
  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  // ユーザー登録（サインアップ）の処理を行うメソッド。
  // メールアドレスとパスワードを引数に取り、BuildContextも受け取ってUI操作（SnackBarの表示）を可能にします。
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // ローディング開始。状態をtrueに設定してUIにローディングを表示させることができます。

    // AuthAPIを通じてサインアップのAPI呼び出しを非同期で行います。
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );

    // API呼び出しの結果を処理します。成功時はユーザー名をコンソールに表示、失敗時はエラーメッセージをSnackBarで表示します。
    res.fold((l) => showSnackBar(context, l.message), // エラー時の処理
        (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: [],
          following: [],
          profilePic: "",
          bannerPic: "",
          uid: "",
          bio: "",
          isTwitterBlue: false);
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.message), (_) {
        showSnackBar(context, "アカウントが作成されました！　ログインして下さい");
        Navigator.push(context, LoginView.route());
      });
    });
    state = false; // ローディング終了。状態をfalseに設定してUIのローディング表示を解除します。
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // ローディング開始。状態をtrueに設定してUIにローディングを表示させることができます。

    // AuthAPIを通じてサインアップのAPI呼び出しを非同期で行います。
    final res = await _authAPI.login(
      email: email,
      password: password,
    );

    // API呼び出しの結果を処理します。成功時はユーザー名をコンソールに表示、失敗時はエラーメッセージをSnackBarで表示します。
    res.fold((l) => showSnackBar(context, l.message), // エラー時の処理
        (r) {
      Navigator.push(context, HomeView.route());
    });
    state = false; // ローディング終了。状態をfalseに設定してUIのローディング表示を解除します。
  }
}
