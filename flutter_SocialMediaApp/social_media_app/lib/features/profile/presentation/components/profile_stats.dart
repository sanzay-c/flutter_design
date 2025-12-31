import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({
    super.key,
    required this.postCount,
    required this.followersCount,
    required this.followingCount,
    required this.onTap,
  });

  final int postCount;
  final int followersCount;
  final int followingCount;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    // textstyle for count
    var textStyleForCount = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    // textstyle for text
    var textStyleForText = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // posts
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  postCount.toString(),
                  style: textStyleForCount,
                ),
                Text(
                  "Post",
                  style: textStyleForText,
                ),
              ],
            ),
          ),
      
          // followers
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  followersCount.toString(),
                  style: textStyleForCount,
                ),
                Text(
                  "Followers",
                  style: textStyleForText,
                ),
              ],
            ),
          ),
      
          // following
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  followingCount.toString(),
                  style: textStyleForCount,
                ),
                Text(
                  "Following",
                  style: textStyleForText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
