// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gap/gap.dart';

import 'package:news_app/presentation/widgets/text_generator.dart';

class ProfilePageBodyCards extends StatelessWidget {
  final Function() onTap;
  final String boldTextPart;
  final String lightTextPart;

  const ProfilePageBodyCards({
    Key? key,
    required this.onTap,
    required this.boldTextPart,
    required this.lightTextPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText(
            text: boldTextPart,
            fontSize: 20,
          ),
          const Gap(5),
          NormalText(
            textAlign: TextAlign.left,
            text: lightTextPart,
            color: Colors.black38,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}
