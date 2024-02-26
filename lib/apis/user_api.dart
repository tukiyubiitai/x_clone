import 'package:x_clone/core/core.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData();
}

class UserApi implements IUserAPI {}
