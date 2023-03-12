// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const BoldText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class NormalText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  TextAlign textAlign;
  NormalText(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 20,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
      textAlign: textAlign,
    );
  }
}
