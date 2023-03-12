// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:news_app/presentation/widgets/text_generator.dart';

class CategoriesListViewItems extends StatelessWidget {
  final Color containerColor;
  final Color textColor;
  final String iconText;
  const CategoriesListViewItems({
    Key? key,
    required this.containerColor,
    required this.textColor,
    required this.iconText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 7,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: containerColor,
      ),
      child: Center(
        child: NormalText(
          text: iconText,
          fontSize: 15,
          color: textColor,
        ),
      ),
    );
  }
}
