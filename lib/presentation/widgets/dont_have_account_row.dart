// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

class DontHaveAccountText extends StatelessWidget {
  final Function() onTap;
  const DontHaveAccountText({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NormalText(
          text: 'Dont have an account? ',
          color: Colors.white,
          fontSize: 17,
        ),
        GestureDetector(
          onTap: onTap,
          child: const BoldText(
            text: 'Create Account',
            color: Colors.white,
            fontSize: 17,
          ),
        )
      ],
    );
  }
}
