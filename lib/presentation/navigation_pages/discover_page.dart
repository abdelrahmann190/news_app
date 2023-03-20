import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/main_page_news_card.dart';
import '../../buisness_logic/cubit/search_news/search_news_dart_cubit.dart';
import '../widgets/auth/customizable_text_field.dart';
import '../widgets/text_generator.dart';

import '../widgets/today_date_formater.dart';

class DiscoverPage extends StatelessWidget {
  final TextEditingController searchFieldController = TextEditingController();
  DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic searchNewsOnSubmitted(
      String searchKeyword,
    ) {
      BlocProvider.of<SearchNewsCubit>(context).getNewsWithSearchKeyword(
        searchKeyword: searchFieldController.text,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
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
                    onSubmitted: searchNewsOnSubmitted,
                  ),
                  const Gap(20),
                ],
              ),
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.only(
                left: 20,
              ),
              color: Colors.white,
              child: BlocBuilder<SearchNewsCubit, SearchNewsState>(
                builder: (context, state) {
                  if (state is SearchNewsLoaded) {
                    return SingleChildScrollView(
                      child: MainNewsPageCard(
                        isDismissible: false,
                        mainNewsList: state.searchNewsList,
                      ),
                    );
                  } else {
                    return showLoadingProgressIndicator(
                        indicatorColor: Colors.black);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showLoadingProgressIndicator({required Color indicatorColor}) {
    return Center(
      child: CircularProgressIndicator(
        color: indicatorColor,
      ),
    );
  }
}
