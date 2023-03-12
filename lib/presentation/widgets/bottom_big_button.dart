import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/colors.dart';
import 'text_generator.dart';

class BottomFilledButton extends StatelessWidget {
  final Function() onTap;
  bool isIconButton;
  IconData? icon;
  double iconSize;
  final String text;
  Color backgroundColor;
  BottomFilledButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.backgroundColor = const Color(
      AppColors.filledButtonColor,
    ),
    this.isIconButton = false,
    this.icon,
    this.iconSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: Center(
          child: isIconButton
              ? iconFilledButton(text, icon!, iconSize)
              : textFilledButton(text),
        ),
      ),
    );
  }

  Widget iconFilledButton(String text, IconData icon, double iconSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        const Gap(7),
        NormalText(text: text),
      ],
    );
  }

  Widget textFilledButton(String text) {
    return NormalText(text: text);
  }
}

class BottomBorderButton extends StatelessWidget {
  bool isIconButton;
  IconData? icon;
  double iconSize;
  final String text;

  BottomBorderButton({
    Key? key,
    this.isIconButton = false,
    required this.text,
    this.icon,
    this.iconSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: isIconButton
            ? iconBorderButton(text, icon!, iconSize)
            : textBorderButton(text),
      ),
    );
  }

  Widget iconBorderButton(String text, IconData icon, double iconSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        const Gap(7),
        NormalText(text: text),
      ],
    );
  }

  Widget textBorderButton(String text) {
    return NormalText(text: text);
  }
}
