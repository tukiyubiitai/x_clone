import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:x_clone/common/common.dart';
import 'package:x_clone/features/auth/controller/auth_controller.dart';
import 'package:x_clone/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => CreateTweetScreen());

  const CreateTweetScreen({super.key});

  @override
  ConsumerState<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          SizedBox(
            width: 100,
            height: 40,
            child: RoundedSmallButton(
              onTap: () {},
              label: "ポストする",
              backgroundColor: Pallete.blueColor,
              textColor: Pallete.backgroundColor,
            ),
          ),
        ],
      ),
      body: currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30, // アバターのサイズを指定
                          backgroundColor: Colors.grey[200], // アイコンの背景色を設定
                          backgroundImage: currentUser.profilePic.isNotEmpty
                              ? NetworkImage(currentUser.profilePic)
                              : null, // 画像データがない場合はnullを設定
                          child: currentUser.profilePic.isEmpty
                              ? Icon(Icons.person,
                                  color: Colors.grey) // 画像がない場合はアイコンを表示
                              : null, // 画像データがある場合は何も表示しない
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: tweetTextController,
                            style: TextStyle(fontSize: 22),
                            decoration: InputDecoration(
                              hintText: "今どうしてる？",
                              hintStyle: TextStyle(
                                color: Pallete.greyColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
