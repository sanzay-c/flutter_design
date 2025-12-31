import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this.onPressed,
    required this.isFollowing,
  });

  final void Function()? onPressed;
  final bool isFollowing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding on outside
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      // button
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MaterialButton(
          onPressed: onPressed,
          //padding inside
          padding: const EdgeInsets.all(9),
          // color
          color: isFollowing
              ? Theme.of(context).colorScheme.primary
              : Colors.orangeAccent,
          // text
          child: Text(
            isFollowing ? "Unfollow" : "Follow",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
