import 'package:flutter/material.dart';

import 'text_generator.dart';

class SignUpPageDividerLine extends StatelessWidget {
  const SignUpPageDividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 2,
            color: Colors.white30,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: NormalText(
            text: 'Or login with',
            color: Colors.white,
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 2,
            color: Colors.white30,
          ),
        ),
      ],
    );
  }
}
