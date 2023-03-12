import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'text_generator.dart';

import 'logo_animated_text.dart';

class TopPartOfAuthPage extends StatelessWidget {
  const TopPartOfAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 90,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                opacity: 0.7,
                image: AssetImage('assets/images/login_page.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/app_logo.png',
                      width: 40,
                    ),
                    const Gap(10),
                    const LogoAnimatedText(),
                  ],
                ),
                const Gap(30),
                const BoldText(
                  text: 'Stay informed with our news app',
                  color: Colors.white,
                  fontSize: 30,
                ),
                const Gap(20),
                NormalText(
                  text:
                      'Always stay in touch with what is happening in the world and around you',
                  fontSize: 16,
                  color: Colors.white,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(),
        ),
      ],
    );
  }
}
