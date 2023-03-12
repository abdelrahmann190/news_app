// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'show_country_flag.dart';
import 'text_generator.dart';

class FlagAndCountryCard extends StatelessWidget {
  final String countryCode;
  final String countryName;
  const FlagAndCountryCard({
    Key? key,
    required this.countryCode,
    required this.countryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(8, 0, 0, 0),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(30),
          NormalText(
            text: flagEmoji(countryCode),
            fontSize: 40,
          ),
          const Gap(20),
          BoldText(
            text: countryName,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}
