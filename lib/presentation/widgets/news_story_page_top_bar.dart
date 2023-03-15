// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NewsStoryTopBar extends StatelessWidget {
  final int currentIndex;
  final int newsCount;
  const NewsStoryTopBar({
    Key? key,
    required this.currentIndex,
    required this.newsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(newsCount, (index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / newsCount,
          child: Container(
            height: 3,
            margin: const EdgeInsets.only(
              left: 3,
              right: 3,
            ),
            decoration: BoxDecoration(
              color: index == currentIndex ? Colors.white : Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}
