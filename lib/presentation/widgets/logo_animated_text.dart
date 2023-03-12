import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LogoAnimatedText extends StatefulWidget {
  const LogoAnimatedText({super.key});

  @override
  State<LogoAnimatedText> createState() => _LogoAnimatedTextState();
}

class _LogoAnimatedTextState extends State<LogoAnimatedText> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'NESNews',
            speed: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
