import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String email,
    required String name,
    required List<String> followers,
    required List<String> following,
    required String profilePic,
    required String bannerPic,
    required String uid,
    required String bio,
    required bool isTwitterBlue,
  }) = _UserModel;
}
