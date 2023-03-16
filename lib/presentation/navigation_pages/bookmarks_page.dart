import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../buisness_logic/cubit/bookmarks_cubit/bookmarks_cubit.dart';
import '../../data/models/news_model.dart';
import '../widgets/home_page_category_list.dart';
import '../widgets/main_page_news_card.dart';
import '../widgets/text_generator.dart';
import '../../utils/strings.dart';

class BookMarksPage extends StatefulWidget {
  const BookMarksPage({super.key});

  @override
  State<BookMarksPage> createState() => _BookMarksPageState();
}

class _BookMarksPageState extends State<BookMarksPage> {
  List<News> bookmarkedNewsList = [];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 100,
              ),
              width: double.infinity,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const BoldText(
                    text: 'My Bookmarks',
                    color: Colors.white,
                    fontSize: 40,
                  ),
                  const Gap(30),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsCatogeries.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          child: CategoriesListViewItems(
                            containerColor: _currentIndex == index
                                ? Colors.white
                                : Colors.white24,
                            textColor: _currentIndex == index
                                ? Colors.black
                                : Colors.white,
                            iconText: newsCatogeries[index],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              color: Colors.white,
              child: buildBookMarkedNewsList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBookMarkedNewsList() {
    setState(() {
      bookmarkedNewsList;
    });
    return BlocBuilder<BookmarksCubit, BookmarksState>(
      builder: (context, state) {
        if (state is BookmarksLoaded) {
          bookmarkedNewsList = state.bookMarkedNews;
          return bookmarkedNewsList.isEmpty
              ? emptyPage()
              : BlocProvider.value(
                  value: BlocProvider.of<BookmarksCubit>(context),
                  child: MainNewsPageCard(
                    isDismissible: true,
                    mainNewsList: state.bookMarkedNews,
                  ),
                );
        } else {
          return showLoadingProgressIndicator(indicatorColor: Colors.black);
        }
      },
    );
  }

  Widget emptyPage() {
    return NormalText(text: 'Wow such empty ....');
  }

  Widget showLoadingProgressIndicator({required Color indicatorColor}) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: indicatorColor,
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<BookmarksCubit>(context).getNewsBookMark();
    super.initState();
  }
}
