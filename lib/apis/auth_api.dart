import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:x_clone/core/core.dart';
import 'package:x_clone/core/providers.dart';

// AppwriteのAccountサービスを使用するためのプロバイダーを定義します。
// これにより、AuthAPIクラスのインスタンスをアプリ全体で簡単に再利用できます。
final authAPIProvider = Provider((ref) {
  // appwriteAccountProviderからAppwriteのAccountオブジェクトを取得します。
  final account = ref.watch(appwriteAccountProvider);
  // AuthAPIクラスのインスタンスを作成し、依存するAccountオブジェクトを注入します。
  return AuthAPI(account: account);
});

// 認証APIのインターフェースを定義する抽象クラスです。
// このインターフェースは、認証に関連するメソッドを実装するクラスに必要な契約を提供します。
abstract class IAuthAPI {
  // ユーザーのサインアップを処理するメソッドのシグネチャです。
  // メールアドレスとパスワードを受け取り、結果としてユーザーオブジェクトまたはエラーを返します。
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  });

  FutureEither<model.Session> login({
    required String email,
    required String password,
  });

  Future<model.User?> currentUserAccount();
}

// IAuthAPIインターフェースを実装するクラスです。
// Appwriteの認証機能を実際に利用してユーザーのサインアップを行います。
class AuthAPI implements IAuthAPI {
  // AppwriteのAccountサービスへの参照を保持します。
  final Account _account;

  // コンストラクタ。AppwriteのAccountオブジェクトを必要とします。
  AuthAPI({required Account account}) : _account = account;

  // ユーザーのサインアップを処理するメソッドの実装部分です。
  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      // AppwriteのAccountサービスを使用して新しいユーザーを作成します。
      final account = await _account.create(
        userId: ID.unique(), // ユニークなユーザーIDを生成します。
        email: email,
        password: password,
      );
      // 処理が成功した場合、作成されたユーザーオブジェクトを返します。
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      // Appwriteで定義されたエラーをキャッチし、エラー情報を含むオブジェクトを返します。
      return left(Failure(
          message: e.message ?? "Some unexpected error occurred",
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      // その他のエラーをキャッチし、エラー情報を含むオブジェクトを返します。
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      // AppwriteのAccountサービスを使用して新しいユーザーを作成します。
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      // 処理が成功した場合、作成されたユーザーオブジェクトを返します。
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      // Appwriteで定義されたエラーをキャッチし、エラー情報を含むオブジェクトを返します。
      return left(Failure(
          message: e.message ?? "Some unexpected error occurred",
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      // その他のエラーをキャッチし、エラー情報を含むオブジェクトを返します。
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  // 登録されているユーザー情報を取得する
  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }
}