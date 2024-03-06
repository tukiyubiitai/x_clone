import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/enums/tweet_type_enum.dart';

part 'tweet_model.freezed.dart';

part 'tweet_model.g.dart';

@freezed
class Tweet with _$Tweet {
  const factory Tweet({
    required String text,
    required List<String> hashtags,
    required String link,
    required List<String> imageLinks,
    required String uid,
    required TweetType tweetType,
    required DateTime tweetedAt,
    required List<String> likes,
    required List<String> commentIds,
    required String id,
    required int reshareCount,
    // required String retweetedBy,
    // required String repliedTo,
  }) = _Tweet;

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);
}
