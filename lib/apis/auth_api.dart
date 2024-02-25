import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:fpdart/fpdart.dart';
import 'package:x_clone/core/core.dart';

abstract class IAuthAPI {
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final account = _account.create(
        userId: "unique()",
        email: email,
        password: password,
      );
      return right(account as model.User);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? "Some unexpected error occurred",
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
