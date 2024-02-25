import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone/core/utils.dart';

import '../../../apis/auth_api.dart';

// AuthControllerのインスタンスを作成し、アプリ全体で利用可能にするためのStateNotifierProviderを定義します。
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  // authAPIProviderからAuthAPIのインスタンスを取得し、AuthControllerに渡します。
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
  );
});

// AuthControllerは、認証関連の状態（この場合はローディング状態）とロジックを管理するクラスです。
class AuthController extends StateNotifier<bool> {
  // AuthAPIのインスタンスを保持します。これを通じて認証関連のAPI呼び出しを行います。
  final AuthAPI _authAPI;

  // コンストラクタ。AuthAPIのインスタンスを受け取り、初期状態をfalse（ローディングしていない）に設定します。
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);

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
    res.fold(
      (l) => showSnackBar(context, l.message), // エラー時の処理
      (r) => print(r.email), // 成功時の処理
    );
    state = false; // ローディング終了。状態をfalseに設定してUIのローディング表示を解除します。
  }
}
