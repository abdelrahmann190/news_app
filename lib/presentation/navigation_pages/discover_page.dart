import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../buisness_logic/cubit/search_news/search_news_dart_cubit.dart';
import '../widgets/auth/customizable_text_field.dart';
import '../widgets/text_generator.dart';

import '../widgets/today_date_formater.dart';

class DiscoverPage extends StatelessWidget {
  final TextEditingController searchFieldController = TextEditingController();
  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 80, left: 20, right: 10),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BoldText(
                  text: 'Explore around you',
                  color: Colors.white,
                  fontSize: 35,
                ),
                const Gap(20),
                NormalText(
                  text: formatter,
                  color: Colors.white70,
                  fontSize: 17,
                ),
                const Gap(40),
                CustomizableTextField(
                  controller: searchFieldController,
                  hintText: 'search news',
                  obscureText: false,
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.white,
                  onSubmitted: searchNewsOnSubmitter(
                    context,
                    searchFieldController.text,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
          Container(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  searchNewsOnSubmitter(
    BuildContext context,
    String searchKeyword,
  ) {
    BlocProvider.of<SearchNewsCubit>(context).getNewsWithSearchKeyword(
      searchKeyword: searchKeyword,
    );
  }
}
