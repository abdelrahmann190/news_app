// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryPageBottomIconsBar extends StatelessWidget {
  final Icon bookmarkIcon;
  final Function() bookmarkOnTap;
  const StoryPageBottomIconsBar({
    Key? key,
    required this.bookmarkIcon,
    required this.bookmarkOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        Wrap(
          spacing: 5,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.chat_bubble_fill,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: bookmarkOnTap,
              icon: bookmarkIcon,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.share,
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
